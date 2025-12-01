//
//  SubscriptionPlanView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct SubscriptionPlanView: View {
    @State private var isMonthly = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 16) {
                        ZStack(alignment: .topTrailing) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.yellow)
                                .offset(x: 8, y: -8)
                        }
                        
                        Text("Unlock Your Full Creative Potential")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text("Choose the plan that fits your creative journey and start making unlimited music.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 32)
                    
                    // Monthly/Yearly Toggle
                    HStack(spacing: 0) {
                        Button(action: { isMonthly = true }) {
                            Text("Monthly")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(isMonthly ? .black : .gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(isMonthly ? Color(white: 0.9) : Color.clear)
                        }
                        
                        Button(action: { isMonthly = false }) {
                            HStack(spacing: 8) {
                                Text("Yearly")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(!isMonthly ? .black : .gray)
                                
                                Text("Save 30%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(8)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(!isMonthly ? Color(white: 0.9) : Color.clear)
                        }
                    }
                    .background(Color(white: 0.95))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    
                    // Free Plan Card
                    PlanCard(
                        title: "Free",
                        subtitle: "Get started with basics",
                        price: "$0",
                        period: "forever",
                        features: [
                            PlanFeature(text: "Standard Quality Audio", note: "Good for casual listening", included: true, isPro: false),
                            PlanFeature(text: "5 Songs Per Day", note: "Limited daily generations", included: true, isPro: false),
                            PlanFeature(text: "Standard Queue", note: "Wait time: 30-60 seconds", included: true, isPro: false),
                            PlanFeature(text: "Watermarks on exports", note: "", included: true, isPro: false),
                            PlanFeature(text: "Standard response time", note: "", included: true, isPro: false)
                        ],
                        buttonText: "Current Plan",
                        isCurrentPlan: true,
                        isPro: false
                    )
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                    
                    // Pro Plan Card
                    PlanCard(
                        title: "Pro",
                        subtitle: "Unlimited creativity",
                        price: isMonthly ? "$9.99" : "$6.99",
                        period: "/month",
                        features: [
                            PlanFeature(text: "High Definition Audio", note: "Studio-quality 320Kbps", included: true, isPro: true),
                            PlanFeature(text: "Unlimited Generations", note: "Create as much as you want", included: true, isPro: true),
                            PlanFeature(text: "Instant Generation", note: "Skip all queues, zero wait!", included: true, isPro: true),
                            PlanFeature(text: "No Watermarks", note: "Clean, professional exports", included: true, isPro: true),
                            PlanFeature(text: "Priority Support", note: "Get help within 24 hours", included: true, isPro: true),
                            PlanFeature(text: "Advanced AI Models", note: "Access to latest features", included: true, isPro: true),
                            PlanFeature(text: "Commercial License", note: "Use in your projects", included: true, isPro: true)
                        ],
                        buttonText: "Start Pro - \(isMonthly ? "$9.99/month" : "$6.99/month")",
                        isCurrentPlan: false,
                        isPro: true,
                        badgeText: "MOST POPULAR"
                    )
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                    
                    // Detailed Feature Comparison
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Detailed Feature Comparison")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        ComparisonTable()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                    
                    // What You Get With Pro
                    VStack(alignment: .leading, spacing: 20) {
                        Text("What You Get With Pro")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 16) {
                            BenefitCard(
                                icon: "bolt.fill",
                                title: "Instant Generation",
                                description: "Skips the queue completely. Your music generates in seconds, not minutes. Perfect for when inspiration strikes!",
                                color: Color(red: 1.0, green: 0.4, blue: 0.6)
                            )
                            
                            BenefitCard(
                                icon: "headphones",
                                title: "Studio Quality Audio",
                                description: "Experience crystal-clear 320Kbps audio. Professional quality that sounds amazing on any device or platform.",
                                color: Color(red: 0.6, green: 0.2, blue: 1.0)
                            )
                            
                            BenefitCard(
                                icon: "questionmark.circle",
                                title: "No Watermarks",
                                description: "Clean, professional exports ready to share. No branding, no limitations, just pure creativity.",
                                color: Color(red: 0.2, green: 0.6, blue: 1.0)
                            )
                            
                            BenefitCard(
                                icon: "infinity",
                                title: "Unlimited Creation",
                                description: "No daily limits. Create as many songs as you want, wherever inspiration strikes. Your creativity, unlimited.",
                                color: Color.green
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                    
                    // Trust Indicators
                    VStack(spacing: 16) {
                        Text("Trusted by 100,000+ Creators")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        
                        HStack(spacing: 24) {
                            TrustIndicator(icon: "shield.fill", text: "Secure Payment", color: .green)
                            TrustIndicator(icon: "arrow.clockwise", text: "Cancel Anytime", color: Color(red: 0.6, green: 0.2, blue: 1.0))
                            TrustIndicator(icon: "headphones", text: "24/7 Support", color: .red)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                    
                    // Savings Calculator
                    if !isMonthly {
                        SavingsCalculator()
                            .padding(.horizontal, 24)
                            .padding(.bottom, 32)
                    }
                    
                    // Social Proof
                    VStack(spacing: 12) {
                        Text("Join Thousands of Happy Creators")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        
                        HStack(spacing: -12) {
                            ForEach(0..<5) { _ in
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                        }
                        
                        HStack(spacing: 4) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 16))
                            }
                        }
                        
                        Text("4.9 out of 5 stars")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text("Based on 12,847 reviews")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                    
                    // Bottom CTA
                    VStack(spacing: 20) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "crown.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                        
                        Text("Ready to Create Unlimited Music?")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text("Join Pro today and unlock instant generation, HQ audio, and unlimited creativity.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "rocket.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                
                                Text("Start Pro - Try Free for 3 Days")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        
                        Text("Then $9.99/month • Cancel anytime")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 16) {
                            HStack(spacing: 4) {
                                Image(systemName: "shield.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                
                                Text("Secure Payment")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            
                            HStack(spacing: 4) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                
                                Text("30-Day Guarantee")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(24)
                    .background(
                        LinearGradient(
                            colors: [Color(red: 1.0, green: 0.5, blue: 0.0).opacity(0.1), Color(red: 0.6, green: 0.2, blue: 1.0).opacity(0.1)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
            }
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Choose Your Plan")
                        .font(.system(size: 18, weight: .semibold))
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct PlanFeature {
    let text: String
    let note: String
    let included: Bool
    let isPro: Bool
}

struct PlanCard: View {
    let title: String
    let subtitle: String
    let price: String
    let period: String
    let features: [PlanFeature]
    let buttonText: String
    let isCurrentPlan: Bool
    let isPro: Bool
    var badgeText: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let badge = badgeText {
                HStack {
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.orange)
                        
                        Text(badge)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.orange)
                        
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                    Spacer()
                }
            }
            
            HStack {
                Text(title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(isPro ? .white : .black)
                
                if isPro {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            
            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(isPro ? .white.opacity(0.9) : .gray)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(price)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(isPro ? .white : .black)
                
                Text(period)
                    .font(.system(size: 16))
                    .foregroundColor(isPro ? .white.opacity(0.9) : .gray)
            }
            .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(features.enumerated()), id: \.offset) { _, feature in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: feature.isPro ? "checkmark.circle.fill" : "checkmark.circle")
                                .foregroundColor(feature.isPro ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color.gray.opacity(0.5))
                                .font(.system(size: 18))
                            
                            Text(feature.text)
                                .font(.system(size: 14))
                                .foregroundColor(isPro ? .white : .black)
                        }
                        
                        if !feature.note.isEmpty {
                            Text(feature.note)
                                .font(.system(size: 12))
                                .foregroundColor(isPro ? .white.opacity(0.8) : .gray)
                                .padding(.leading, 26)
                        }
                    }
                }
            }
            .padding(.top, 8)
            
            Button(action: {}) {
                HStack {
                    if isPro {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }
                    
                    Text(buttonText)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isPro ? .white : .black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    isPro ?
                    LinearGradient(
                        colors: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 0.6, green: 0.2, blue: 1.0)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ) :
                    LinearGradient(colors: [Color.gray.opacity(0.2)], startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(12)
            }
            .disabled(isCurrentPlan)
            
            if isPro {
                Text("3-day free trial • Cancel anytime")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(24)
        .background(
            isPro ?
            LinearGradient(
                colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                startPoint: .leading,
                endPoint: .trailing
            ) :
            LinearGradient(colors: [Color.white], startPoint: .leading, endPoint: .trailing)
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isPro ? Color.clear : Color(white: 0.8), lineWidth: 1)
        )
    }
}

struct ComparisonTable: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Feature")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Free")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                
                Text("Pro")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color(white: 0.95))
            
            ComparisonRow(feature: "Audio Quality", free: "Standard 128Kbps", pro: "HD 320Kbps")
            ComparisonRow(feature: "Daily Generations", free: "5 songs", pro: "∞", isPro: true)
            ComparisonRow(feature: "Generation Speed", free: "30-60s wait", pro: "Instant", isPro: true)
            ComparisonRow(feature: "Watermarks", free: "✗", pro: "✓", isPro: true)
            ComparisonRow(feature: "Max Song Length", free: "2 minutes", pro: "5 minutes")
            ComparisonRow(feature: "Commercial Use", free: "✗", pro: "✓", isPro: true)
            ComparisonRow(feature: "Download Formats", free: "MP3", pro: "MP3, WAV, FLAC")
            ComparisonRow(feature: "AI Model Access", free: "Basic", pro: "Advanced")
            ComparisonRow(feature: "Priority Support", free: "✗", pro: "✓", isPro: true)
            ComparisonRow(feature: "Early Access Features", free: "✗", pro: "✓", isPro: true)
        }
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(white: 0.8), lineWidth: 1)
        )
    }
}

struct ComparisonRow: View {
    let feature: String
    let free: String
    let pro: String
    var isPro: Bool = false
    
    var body: some View {
        HStack {
            Text(feature)
                .font(.system(size: 13))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(free)
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
            
            HStack {
                if isPro {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.6))
                        .font(.system(size: 14))
                }
                
                Text(pro)
                    .font(.system(size: 13))
                    .foregroundColor(isPro ? .black : .gray)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.white)
    }
}

struct BenefitCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .background(Color(white: 0.98))
        .cornerRadius(12)
    }
}

struct TrustIndicator: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
            
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
}

struct SavingsCalculator: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Calculate Your Savings")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Monthly Plan")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text("$9.99/mo")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("($119.88/year)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Yearly Plan")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text("$6.99/mo")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("(billed annually, $83.88/year)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(white: 0.95))
            .cornerRadius(12)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 16))
                
                Text("You Save $36.00")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.green)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(12)
            
            Text("That's 3 months free when you choose yearly billing!")
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .background(Color(white: 0.98))
        .cornerRadius(16)
    }
}

#Preview {
    SubscriptionPlanView()
}

