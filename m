Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F617752BC6
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 22:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjGMUkl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjGMUkk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 16:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590E1FD6
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689280791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60cvdq5oE5S+4O6Au451icacUmsO1NSy6BojUatczSw=;
        b=FItOLZu0jS4/IMRSPreOBsEAFWPlnkF7vdtsLBtqnzAIQ9VzLz/OUkn7InRMtu09DpvWrm
        IgJErKaOBQkdlA6DqBuYkbAYfDwzHOWkiCg9oInMQLYUJZcUTNRE7MOOhZNdoqpBwzK8ob
        VULq4KfvdtQc7n5bf1AEKE0bCTRs6+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-mU9dxVCZOCa5txsNHUdiBA-1; Thu, 13 Jul 2023 16:39:49 -0400
X-MC-Unique: mU9dxVCZOCa5txsNHUdiBA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-315af0252c2so805504f8f.0
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 13:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280781; x=1691872781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60cvdq5oE5S+4O6Au451icacUmsO1NSy6BojUatczSw=;
        b=FR4pucCxqwx4b8ampitxT8U1zBSkWvg9SaMvslMxfS7Thx3sTM02KNNNxwurexn3QH
         MQ8kTAPnI+nh7aX+7OSIUR7p4iSWWAmcCPWlcCFSs39rc5nTqv08z8b71B2Fb/POotjD
         TONvgiqJ7QrZM6cGidhW6EXtnUPKMFTJkCOc3DXpuCuW2HB7HqT6w0WuBEuTP68UWlKc
         mb4/odNeI0lK+fWqNiE6BiAYHKxKEEKKnn3BZPmsiXMqUXwpjepg3LmFaSOw1Cbg6ewS
         AvwGQZn4gLVuTWo/lt/oCVQysA1oES2tRvbH9bL0E/CXqCb1P95BEhuQzR34ypylMpM2
         NpKw==
X-Gm-Message-State: ABy/qLZuKRNkSLx/55m6M+4iVWa9NKvVqrbMq4t5YARuxBGMn+IlP14s
        o+O6OvBH4as19wl1EiogCj1YkhYXtGF30YFKpuGckns2weYSNcPOuoqswwFEpSCII6yusmrpazd
        buFduwYSLvzajllLEUR1L
X-Received: by 2002:a5d:4c45:0:b0:313:dec6:a2fb with SMTP id n5-20020a5d4c45000000b00313dec6a2fbmr2313930wrt.6.1689280781807;
        Thu, 13 Jul 2023 13:39:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFFORkyeOUbDVeCk6/Rec0el8E984aDlWqPlT5aBOLVgslLk9PjkmZ56QEqC94+4S/3bliG7Q==
X-Received: by 2002:a5d:4c45:0:b0:313:dec6:a2fb with SMTP id n5-20020a5d4c45000000b00313dec6a2fbmr2313909wrt.6.1689280781522;
        Thu, 13 Jul 2023 13:39:41 -0700 (PDT)
Received: from [192.168.95.46] ([213.55.224.225])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d6752000000b0031434cebcd8sm8843845wrw.33.2023.07.13.13.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 13:39:41 -0700 (PDT)
Message-ID: <33e7d819-ac81-2a14-3cfa-c7a470dc4ceb@redhat.com>
Date:   Thu, 13 Jul 2023 22:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Content-Language: de-CH
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <ZLABozIRVGmwuIBf@gambale.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Ok in case I'll cc you. Thanks a lot!

Emanuele

Am 13/07/2023 um 15:52 schrieb Ard Biesheuvel:
> (add linux-efi@ cc)
> 
> On Thu, Jul 13, 2023 at 03:33:38PM +0200, Ard Biesheuvel wrote:
>> Hello Emanuele,
>>
>> Please cc the linux-efi@ mailing list and myself on EFI related patches.
>>
>> First of all, I think the tone of the discussion is way out of hand on
>> both sides of the debate. Please keep it civil and courteous

