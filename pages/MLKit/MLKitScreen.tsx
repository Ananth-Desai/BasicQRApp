/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

 import React from 'react';
 import { requireNativeComponent, SafeAreaView, StyleSheet, Text } from 'react-native';
 import { useNavigation } from '@react-navigation/native';
 
 const MLKitView = requireNativeComponent('MLKitView')

 function MLKitScreen(): React.JSX.Element {
    const navigation = useNavigation()

     return (
         <SafeAreaView style={styles.backgroundStyle}>
             <Text style={styles.text}>ML Kit Screen</Text>
             <MLKitView 
                style={{height: "100%"}} 
                onSuccessfulScan={(result) => {
                    console.log("Result: ", result.nativeEvent.result);
                    navigation.goBack();
                }}
             />
         </SafeAreaView>
     );
 }
 
 const styles = StyleSheet.create({
     backgroundStyle: {
         backgroundColor: "white",
         height: "100%"
     },
     text: {
         textAlign: 'center',
     }
 })
  
 export default MLKitScreen;
  