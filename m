Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194AA70425D
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 02:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbjEPAly (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 20:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjEPAlx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 20:41:53 -0400
Received: from sender3-of-o57.zoho.com (sender3-of-o57.zoho.com [136.143.184.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8430FD;
        Mon, 15 May 2023 17:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684197665; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=XqR1E9WYKCH5zE0xzfY8q4o8hGEYSOcK4tGK8Q2iZaxhLN15Hn9ctmHY8DtzrsYk2A5JcUeaikJSlwkgyABpztvRWjet1OYjyGyL7URMv+qwqpyjSYxr5HsuEOVzD0Xal0X8RUmyepOxiwtPHvYTxubO8ftpTOFqd94yQnxZSGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1684197665; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=x9E1sPNjs8TnJyDDWuPW+7RruRAouFKTsWP7ZU6lxAw=; 
        b=edBBMwqoIA3px3KRjoqOeVRGIRAKy1Ii6k5VvgFlZblTWvXISxJ1iWXnImdMo8Z/jsjvfy/JPv/0fwx9Up2i0+vuBxSIPlzcAfciWFQyaK2FjPCqIwH/tjXIHcBVW1csLV8OOcA9IABP7hzKJhzpdhsMssnbz7X4BgC83UfqkGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684197665;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=x9E1sPNjs8TnJyDDWuPW+7RruRAouFKTsWP7ZU6lxAw=;
        b=KkBrhxus1IChftrmWFiE0iWqNP8pwvcEA93j1NsBljZB12Dwn/pFRs9ba7CJ9Wc7
        edP2pGXBARtnJM2FPzweZ/GrpdlaMrUSCdjtpbMPbNg2rK5PpKzF9po1PYMenL2dJZy
        M3Z+MoI/+mmQL2JgJ9L9p3qb/TwugPj5kW90GVqc=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1684197664523566.236879037264; Mon, 15 May 2023 17:41:04 -0700 (PDT)
Message-ID: <df9d1260-41dd-034b-9dc6-14173c6c0d25@apertussolutions.com>
Date:   Mon, 15 May 2023 20:41:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
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
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <20230515212206.GA2162@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/15/23 17:22, Matthew Garrett wrote:
> On Mon, May 15, 2023 at 05:15:15PM -0400, Daniel P. Smith wrote:
>> On 5/12/23 06:55, Matthew Garrett wrote:
>>> On Thu, May 04, 2023 at 02:50:13PM +0000, Ross Philipson wrote:
>>>
>>>> +#define SLR_TABLE_MAGIC		0x4452544d
>>>
>>>   From convention I'd expect this to be 0x534c5254, but not really an
>>> issue.
>>
>> Apologies, but which convention?
> 
> Tables in ACPI and UEFI tend to have magic that corresponds to their
> name, so a table called SLRT would tend to have magic that matches the
> ASCII values for that. In this case the SLRT has DRTM as its magic,
> which is a touch unexpected.

While the SLRT is meant for UEFI and non-UEFI environments, DRTM is 
definitely a hold over when we started this and you are correct, 
probably not the best choice. In fact, I agree that SLRT is a far better 
magic. We will update the spec and fix it in the series.

>>> Oof. Having the kernel know about bootloaders has not worked out super
>>> well for us in the past. If someone writes a new bootloader, are they
>>> unable to Secure Launch any existing kernels? The pragmatic thing for
>>> them to do would be to just pretend they're grub, which kind of defeats
>>> the point of having this definition...
>>
>> Actually, this is not for making the kernel know about bootloaders. This is
>> dealing with the challenge created when the preamble was split for efi-stub,
>> and similar use cases, where what sets up the preamble, ie. the bootloader,
>> is separate from what invokes the dynamic launch, ie. the DLE handler. The
>> reality is that even in the simplest implementation of the DLE handler, a
>> remnant of GRUB for call back from efi-stub, there is information that is
>> needed to cross the gap.
> 
> What if I don't use grub, but use something that behaves equivalently?
> Which value should be used here?

Generally we would request that the bootloader submit a request to 
register for a value to be reserved in the spec. That aside, the intent 
here is to allow for the possibility for the DLE handler to be 
independent from the bootloader, but this does not have to be this way. 
If a non-open entity decides to produce their own implementation, they 
can freely use a unallocated value at their own risk that it could be 
allocated to another bootloader in the future. Though in this scenario 
it likely would not matter as the non-open DLE handler would only be 
present when the non-open bootloader was present.

>> We wrote the TrenchBoot Secure Launch general spec [1] with as much
>> forethought as possible for the target environments. Specifically, the
>> desire is to have a common approach for x86 (Intel and AMD), Arm, and
>> perhaps down the road the POWER arch. In particular, I do not believe there
>> is anything in the Arm DRTM beta spec that prohibits a mixed 32/64 bit
>> environment. In the end it is better to for the spec to be safe for those
>> environments then having to make changes to the spec later down the road.
> 
> Ok.

Thank you for the review!

v/r,
dps
