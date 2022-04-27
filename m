Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A444C510EE0
	for <lists+linux-efi@lfdr.de>; Wed, 27 Apr 2022 04:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356820AbiD0Ckp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 22:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357196AbiD0Cko (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 22:40:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1633E5C1;
        Tue, 26 Apr 2022 19:37:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kp2q01xLHzCsQ2;
        Wed, 27 Apr 2022 10:33:00 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 10:37:29 +0800
Message-ID: <c48a42b1-a25c-cb69-4242-2a964ac4ad05@huawei.com>
Date:   Wed, 27 Apr 2022 10:37:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: How to list keys used for kexec
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
CC:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <20220414175930.GM163591@kunlun.suse.cz>
 <853635d6-9e74-c3dc-f6dc-d4166616c8e5@huawei.com>
 <20220426085220.GE163591@kunlun.suse.cz>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <20220426085220.GE163591@kunlun.suse.cz>
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

On 2022/4/26 16:52, Michal Suchánek wrote:
> On Tue, Apr 26, 2022 at 12:10:13PM +0800, Guozihua (Scott) wrote:
>> On 2022/4/15 1:59, Michal Suchánek wrote:
>>> Hello,
>>>
>>> apparently modules are verified by keys from 'secondary' keyring on all
>>> platforms.
>>>
>>> If you happen to know that it's this particular keyring, and know how
>>> to list keyrings recursively you can find the keys that are used for
>>> verifying modules.
>>>
>>> However, for kexec we have
>>>
>>>    - primary keyring on aarch64
>>>    - platform keyring on s390
>>>    - secondary AND platform keyring on x86
>>>
>>> How is a user supposed to know which keys are used for kexec image
>>> verification?
>>>
>>> There is an implicit keyring that is ad-hoc constructed by the code that
>>> does the kexec verification but there is no key list observable from
>>> userspace that corresponds to this ad-hoc keyring only known to the kexec
>>> code.
>>>
>>> Can the kernel make the information which keys are used for what purpose
>>> available to the user?
>>>
>>> Thanks
>>>
>>> Michal
>>>
>>> .
>>
>> Hi Michal
>>
>> I'll try my best to understand and answer your question.
>>
>> First of all, the "key" you mentioned here is actually certificate. And
>> there are no way for the kernel to know "which certificate is used for what
>> purpose" but to get a hint from the certificate's extension, if they exist.
>> However, the extension only points out what this certificate should be used
>> for, but not exactly what it is actually used for.
> 
>> Secondly, the verification process requires the module (kernel image in this
>> question) to contain information on which certificate should be used to
>> verify itself. The signature provided by the module is in PKCS#7 format
>> which contains a list of certificates for the verifier to construct a "chain
>> of trust". Each certificates contains information pointing to the
>> certificate of it's issuer, and eventually to one of the certificate stored
>> in one of the keyrings you mentioned.
> 
> Indeed, that's not really relevant to this problem.
> Sure, if the certificates extension does exist and does not state that
> the certificate can be used for code signing then the signature should
> be rejected. The same if the signature is malformed and does not provide
> enough information to determine which key was used to create it.
> 
> The question which key will be checked, though.
>>
>> All in all, certificates in these keyrings you mentioned can be used for
>> various purpose, and it's the responsibility for the modules being verified
>> to provide information stating which certificate should be used for
>> verification. Thus, the best way to find out which key is used for kexec is
>> to look at key used to sign the kernel image.
> 
> There aren't really good tools for working with the kernel signatures
> but I can tell what certificate it was signed with jumping throught some
> hoops.
> 
> What I can't tell without reading the kernel code (different for each
> architecture) is what certificates the kernel considers valid for
> signing kernels. The kernel surely knows but does not tell.

It's quite true on this one, maybe some documentation would help.
> 
> That is, for example, if I have a known bad kernel I want to be able to
> tell if it's loadable without actually loading it.

For this you can try the -l option with kexec which loads the kernel but 
will not execute it. And then you can use -u option to unload the kernel 
again and see whether it resolves your requirement.
> 
> Thanks
> 
> Michal
> .

-- 
Best
GUO Zihua
