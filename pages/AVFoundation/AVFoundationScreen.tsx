/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import { requireNativeComponent, SafeAreaView, StyleSheet, Text } from 'react-native';
import { useNavigation } from '@react-navigation/native';

const AVFoundationView = requireNativeComponent('AVFoundationView');

function AVFoundationScreen(): React.JSX.Element {
    const navigation = useNavigation()
    return (
        <SafeAreaView style={styles.backgroundStyle}>
            <Text style={styles.text}>AV Foundation Screen</Text>
            <AVFoundationView 
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
 
export default AVFoundationScreen;
 