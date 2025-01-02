/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

 import React from 'react';
 import { Button, FlatList, SafeAreaView, StyleSheet, Text } from 'react-native';
  
 
 function Home({navigation}): React.JSX.Element {
     return (
         <SafeAreaView style={styles.backgroundStyle}>
             <FlatList 
                data={[
                    {
                        id: 'AVFoundation',
                        name: 'AV Foundation'
                    },
                    {
                        id: 'MLKit',
                        name: 'ML Kit',
                    },
                    {
                        id: 'VisionKit',
                        name: 'Vision Kit'
                    },
                    {
                        id: 'Vision',
                        name: 'Vision'
                    }
                ]}
                renderItem={(item) => 
                    <Button 
                        title={item.item.name}
                        onPress={() =>
                            navigation.navigate(item.item.id)
                        } 
                    />}
                style={styles.list}
             />
         </SafeAreaView>
     );
 }
 
 const styles = StyleSheet.create({
     backgroundStyle: {
         backgroundColor: "white",
         flex: 1,
         alignItems: 'center',
         justifyContent: 'center',
     },
     list: {
         textAlign: 'center',
         height: 'auto',
         marginTop: "50%",
     }
 })
  
 export default Home;
  