Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308FB6FCAF6
	for <lists+linux-efi@lfdr.de>; Tue,  9 May 2023 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEIQQX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 May 2023 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEIQQW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 May 2023 12:16:22 -0400
X-Greylist: delayed 372 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 09:16:19 PDT
Received: from sender3-of-o58.zoho.com (sender3-of-o58.zoho.com [136.143.184.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453324202;
        Tue,  9 May 2023 09:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683648561; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=e8z1GRKHIutI17sD6Ooa+GsqxZ6LiVUfaM2CBuq8Fnl8NkgMxccjJcIrLDwAp2AUFpse+WGI2R/+IhIwcdj+ZpURqgiXFh/3MQANM/u/SrCS5YDPCYRVn3jlne5PxwqF9qHJUE+2udAR3VOFk0gcRTuEqSXVNS1vmXslPZQ4KMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683648561; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qGk4Rls13lFQhdUfzwlL+5GIuudpucnLpMrkFUq4WaI=; 
        b=EuJwYk5JFudfE1FA1+kyp1s7cosrwAQvGkYpJIqCWrw/drRm7W3tBpSTR8qG1T0YVT679qzwII3KdnJmusJ9i50PdxKmXiEfZqRml52LXLn8BqSGyKJmx54K5jjLh3TWp9uzlAdMPLU3RIq2iHBdCga2Hjm7FAPPC4PZQmuzirg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683648561;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=qGk4Rls13lFQhdUfzwlL+5GIuudpucnLpMrkFUq4WaI=;
        b=SNFsz95maKu0/BHCbIqIyqUPOIR4r7MdlMd2xIlqC3KZ/LoT7dARRjOYEYESg5CP
        0/GLY2THkxoK8LM8zNM85SqghmumzF7tBHxSS7X/VzJIeyypFttd0ukbH/+B0G2CV21
        DHNisWZA600cfK7c2MQCmBpROG/vdDyyDEiXN2U8=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1683648559080793.9506296306162; Tue, 9 May 2023 09:09:19 -0700 (PDT)
Message-ID: <dad2d0b2-65d6-89bf-d2f0-7f420436e44c@apertussolutions.com>
Date:   Tue, 9 May 2023 12:09:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <ZFUwLjPfhz8Ch9bE@kernel.org>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <ZFUwLjPfhz8Ch9bE@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 12:34, Simon Horman wrote:
> On Thu, May 04, 2023 at 02:50:15PM +0000, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The SHA algorithms are necessary to measure configuration information into
>> the TPM as early as possible before using the values. This implementation
>> uses the established approach of #including the SHA libraries directly in
>> the code since the compressed kernel is not uncompressed at this point.
>>
>> The SHA code here has its origins in the code from the main kernel:
>>
>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>>
>> That code could not be pulled directly into the setup portion of the
>> compressed kernel because of other dependencies it pulls in. The result
>> is this is a modified copy of that code that still leverages the core
>> SHA algorithms.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/boot/compressed/Makefile       |  2 +
>>   arch/x86/boot/compressed/early_sha1.c   | 97 +++++++++++++++++++++++++++++++++
>>   arch/x86/boot/compressed/early_sha1.h   | 17 ++++++
>>   arch/x86/boot/compressed/early_sha256.c |  7 +++
>>   lib/crypto/sha1.c                       |  4 ++
>>   lib/crypto/sha256.c                     |  8 +++
>>   6 files changed, 135 insertions(+)
>>   create mode 100644 arch/x86/boot/compressed/early_sha1.c
>>   create mode 100644 arch/x86/boot/compressed/early_sha1.h
>>   create mode 100644 arch/x86/boot/compressed/early_sha256.c
>>
>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index 6b6cfe6..1d327d4 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -112,6 +112,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>   vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>>   vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>   
>> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
>> +
>>   $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>   	$(call if_changed,ld)
>>   
>> diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
>> new file mode 100644
>> index 0000000..524ec23
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/early_sha1.c
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Apertus Solutions, LLC.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/linkage.h>
>> +#include <linux/string.h>
>> +#include <asm/boot.h>
>> +#include <asm/unaligned.h>
>> +
>> +#include "early_sha1.h"
>> +
>> +#define SHA1_DISABLE_EXPORT
> 
> Hi Ross,
> 
> I could be mistaken, but it seems to me that *_DISABLE_EXPORT
> is a mechanism of this patch to disable exporting symbols
> (use of EXPORT_SYMBOL), at compile time.
> 
> If so, this doesn't strike me as something that should be part of upstream
> kernel code.  Could you consider dropping this part of the patch?

Greetings Simon,

This was patterned after the move of sha256 to /lib. Upon re-inspection, 
it appears this has since been updated to use the __DISABLE_EXPORTS 
CFLAG mechanism of EXPORT_SYMBOL as a conditionally included rule in the 
Makefile where the desire to disable exporting is wanted. We will update 
this patch to follow the same pattern.

V/r,
Daniel P. Smith
