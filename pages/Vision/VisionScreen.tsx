/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

 import React from 'react';
 import { requireNativeComponent, SafeAreaView, StyleSheet, Text } from 'react-native';
 import { useNavigation } from '@react-navigation/native';


 const VisionView = requireNativeComponent('VisionView')
 
 function VisionScreen(): React.JSX.Element {
    const navigation = useNavigation()

     return (
         <SafeAreaView style={styles.backgroundStyle}>
             <Text style={styles.text}>Vision  Screen</Text>
             <VisionView
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
  
 export default VisionScreen;
  