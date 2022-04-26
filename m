Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A108C50EF9B
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 06:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiDZENX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 00:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiDZENW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 00:13:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18761080;
        Mon, 25 Apr 2022 21:10:15 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KnT1P2SRFzhYqg;
        Tue, 26 Apr 2022 12:10:01 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 12:10:13 +0800
Message-ID: <853635d6-9e74-c3dc-f6dc-d4166616c8e5@huawei.com>
Date:   Tue, 26 Apr 2022 12:10:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: How to list keys used for kexec
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <20220414175930.GM163591@kunlun.suse.cz>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <20220414175930.GM163591@kunlun.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022/4/15 1:59, Michal Suchánek wrote:
> Hello,
> 
> apparently modules are verified by keys from 'secondary' keyring on all
> platforms.
> 
> If you happen to know that it's this particular keyring, and know how
> to list keyrings recursively you can find the keys that are used for
> verifying modules.
> 
> However, for kexec we have
> 
>   - primary keyring on aarch64
>   - platform keyring on s390
>   - secondary AND platform keyring on x86
> 
> How is a user supposed to know which keys are used for kexec image
> verification?
> 
> There is an implicit keyring that is ad-hoc constructed by the code that
> does the kexec verification but there is no key list observable from
> userspace that corresponds to this ad-hoc keyring only known to the kexec
> code.
> 
> Can the kernel make the information which keys are used for what purpose
> available to the user?
> 
> Thanks
> 
> Michal
> 
> .

Hi Michal

I'll try my best to understand and answer your question.

First of all, the "key" you mentioned here is actually certificate. And 
there are no way for the kernel to know "which certificate is used for 
what purpose" but to get a hint from the certificate's extension, if 
they exist. However, the extension only points out what this certificate 
should be used for, but not exactly what it is actually used for.

Secondly, the verification process requires the module (kernel image in 
this question) to contain information on which certificate should be 
used to verify itself. The signature provided by the module is in PKCS#7 
format which contains a list of certificates for the verifier to 
construct a "chain of trust". Each certificates contains information 
pointing to the certificate of it's issuer, and eventually to one of the 
certificate stored in one of the keyrings you mentioned.

All in all, certificates in these keyrings you mentioned can be used for 
various purpose, and it's the responsibility for the modules being 
verified to provide information stating which certificate should be used 
for verification. Thus, the best way to find out which key is used for 
kexec is to look at key used to sign the kernel image.

-- 
Best
GUO Zihua
