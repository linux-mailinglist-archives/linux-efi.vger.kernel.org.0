Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEE474B73D
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 21:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGGTi5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 15:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjGGTgB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 15:36:01 -0400
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9060E269F;
        Fri,  7 Jul 2023 12:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688758303; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=EwVRDfNxcmQnOtFGleOVrjIkgKRwh7y52cIfKN0GFaKN0OBxQFBpkW0gztPv2rTPKlsHRlXNwqX0V7X/g+5tbnDalixwm2P/depB+msJkqw/5QsMvebiIudbxXZcK1IbibAsD9T0IWr/xFfu3sBT8tHUKltieu6YOTNc2Jmrb0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1688758303; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fHoswupnpLAD4heKyuTd/2GZhFPZ+XaZr9DP5UrvceM=; 
        b=DqSq9DCKsV8NNFqKvMsP7CH363mjfejdsBrrzQySj2V3OvRaWyj+oqjlPq7Epav31II3NSHM/7frG+F6Y1XfRgBLU0KRRwB9dW4hauAHB+OjLS5TlBRetCewMpONDWbHiwkl967kv0nYSIzxfV2EGWvZw+ADN9A1drGyDR7Yv1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688758303;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:From:From:Subject:Subject:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=fHoswupnpLAD4heKyuTd/2GZhFPZ+XaZr9DP5UrvceM=;
        b=HoM7R2M40mW1tdXIy+g2mlEdzq4NQsxSZwuCWYH0mXFXkpb8z1J7gKkVr6gGnG0W
        ThRDcJKAEMQPpH/O0wwTDLv9oL/6evwho0H4lNX1iHqyRIe2OeOj97Jr0LvSCMlnL99
        foaIXq91NT2RQ/qveQIN7YXB140UETdVegWIRZHg=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1688758300880456.56534128910005; Fri, 7 Jul 2023 12:31:40 -0700 (PDT)
Message-ID: <df033b7b-54ce-504a-47d6-1b92ea1038f7@apertussolutions.com>
Date:   Fri, 7 Jul 2023 15:31:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <20230512105554.GB14461@srcf.ucam.org>
 <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
 <20230515212206.GA2162@srcf.ucam.org>
 <df9d1260-41dd-034b-9dc6-14173c6c0d25@apertussolutions.com>
 <20230516014310.GA5403@srcf.ucam.org>
 <eda6da3a-00fe-21c5-5a3d-3e06d21179f4@apertussolutions.com>
 <20230616201513.GA30963@srcf.ucam.org>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
In-Reply-To: <20230616201513.GA30963@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/16/23 16:15, Matthew Garrett wrote:
> On Fri, Jun 16, 2023 at 04:01:09PM -0400, Daniel P. Smith wrote:
>> On 5/15/23 21:43, Matthew Garrett wrote:
>>> On Mon, May 15, 2023 at 08:41:00PM -0400, Daniel P. Smith wrote:
>>>> On 5/15/23 17:22, Matthew Garrett wrote:
>>>>> What if I don't use grub, but use something that behaves equivalently?
>>>>> Which value should be used here?
>>>>
>>>> Generally we would request that the bootloader submit a request to register
>>>> for a value to be reserved in the spec. That aside, the intent here is to
>>>> allow for the possibility for the DLE handler to be independent from the
>>>> bootloader, but this does not have to be this way. If a non-open entity
>>>> decides to produce their own implementation, they can freely use a
>>>> unallocated value at their own risk that it could be allocated to another
>>>> bootloader in the future. Though in this scenario it likely would not matter
>>>> as the non-open DLE handler would only be present when the non-open
>>>> bootloader was present.
>>>
>>> Is the expectation that the DLE will always be shipped with the
>>> bootloader? I think I'm not entirely clear on what's consuming this and
>>> why.
>>>
>>
>> No, in fact, an early idea proposed by a pair of us in the TrenchBoot
>> community was to have it live either as a Runtime Service that was loaded by
>> a UEFI app or in the coreboot UEFI payload.
> 
> Ok, then I think I'm still confused. If I want to write a new bootloader
> but make use of the existing DLE, what contract am I establishing and
> what value should I be putting in here?

Apologies on the delayed response, vacation and what not.

I believe I know where the confusion is coming from, let me see if I can 
explain better by why that field came about. The motivation for the SLRT 
came out of our agreement to use a callback mechanism to support 
entering efi-stub and then going back to a dynamic launch aware hook to 
complete the initiation of the dynamic launch. The SLRT was devised as a 
platform and kernel agnostic means to handle the launch. As such, there 
was a desire to use that interface, and the underlying DLE code, whether 
GRUB was launching the kernel via the UEFI interface or the traditional 
interface. Skipping the details, but it boils down to the fact that in 
the non-UEFI case, functionality from core GRUB was needed. As a result, 
to provide maximum flexibility for other bootloaders, and to make it 
easier on us, we add the ability to pass a context object across the 
interface. Thus allowing GRUB's DLE handler to have a single entry that 
could be called externally by efi-stub or directly from GRUB proper.

IOW, the bootloader context is a means to provide a bootloader with them 
means to implement a private interface between the bootloader proper and 
a DLE handler that it installed into memory should its implementation 
require it.

There is an underlying question within your question, and that is of 
reuse. In this case, we wrote GRUB's DLE handler was written 
specifically to be used by GRUB. It was written to provide a stable and 
demonstrable implementation of the SL interface. In the future it may 
get refactored or a common standalone implementation, e.g., the 
previously mentioned UEFI runtime service, may arise that would be 
reusable by multiple bootloaders.

I hope this helped explain the purpose and use of this area of the 
table. Please let me know if it did not.

V/r,
DPS
