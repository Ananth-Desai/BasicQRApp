/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

 import React, { useState } from 'react';
 import type {PropsWithChildren} from 'react';
 import {
   SafeAreaView,
   useColorScheme,
   requireNativeComponent,
   Button,
   NativeModules,
   FlatList,
   Text
 } from 'react-native';
 
 import {
   Colors,
 } from 'react-native/Libraries/NewAppScreen';
 
 function TestingView(): React.JSX.Element {
   const InputFieldView = requireNativeComponent("InputFieldView")
   const isDarkMode = useColorScheme() === 'dark';
   let [items, setItems] = useState<string[]>(['One', 'Two', 'Three'])
 
   const backgroundStyle = {
     backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
     height: "100%"
   };
 
   console.log(NativeModules.TestModule.parameter)
   NativeModules.TestModule.getValue(value => {
     console.log(value)
   })
 
   return (
     <SafeAreaView style={backgroundStyle}>
       <InputFieldView style={{ 
         height: 40,
         borderWidth: 0.5,
         marginHorizontal: 30,
         borderRadius: 10,
         marginTop: 20,
         borderColor: "gray"
       }}
       initialValue={'Test String'} 
       onReturn={(value) => {
         console.log(value.nativeEvent.item)
         setItems([value.nativeEvent.item])
       }}
       />
 
       <Button 
         title='Call Async Method'
         onPress={() => {
           NativeModules.TestModule.getValueAsync().then((value) => {
             console.log("Returned a value: ", value)
           }).catch((error) => {
             console.log("Returned an error: ", error.code)
           })
         }}
       />
 
       <FlatList
         data={items}
         renderItem={({item}) => <Text>{item}</Text>}
         keyExtractor={item => item}
         style={styles.inputField}
       />
 
     </SafeAreaView>
   );
 }
 
 const styles = {
   inputField: {
     backgroundColor: "white",
     borderWidth: 2,
     padding: 20,
     height: 100,
     marginTop: 30,
     marginHorizontal: 30,
     borderColor: "black"
   }
 }
 
 export default TestingView;
 