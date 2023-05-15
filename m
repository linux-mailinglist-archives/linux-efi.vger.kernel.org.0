Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7240703F9D
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbjEOVYu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 17:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbjEOVYs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 17:24:48 -0400
Received: from sender3-of-o57.zoho.com (sender3-of-o57.zoho.com [136.143.184.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BEB93
        for <linux-efi@vger.kernel.org>; Mon, 15 May 2023 14:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684185838; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZIiZUK8CbsCjiTqifI36HGbNwdFEP03mJGK5C8Kha6tVgBHP7kTeDgac2+tm/3XKsbDwlkOFJ/4w8cRPeVL3VnzwjCti5eH0DCyA7nRLJ2JNfQf3waGrN8Im9OQOKRHiOK1HYANwB1hR+/nL++Mh9g4UH04TowwykuQggdzSLmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1684185838; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=J3jOAuTNmPzCg2cyhMylK3GtU6TzEwrGngq9Y/KQJiQ=; 
        b=cnbHjhH3F53ydRLRJExkPQrkix1xEpSDV/QLM4ZhENvB8JWNC30Qi41n8QwfXr1lfHGN/YmMLLMNwyQsTv98sg/0V4f3O+tHQDqhjAIoHYJZ/thkTLADCVHMRTTvyki4fJ4V30mYXdS1uR0cpUEo47jhgIfqJnxd1do0v+cYM9w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684185838;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=J3jOAuTNmPzCg2cyhMylK3GtU6TzEwrGngq9Y/KQJiQ=;
        b=XF+jDcK+OfGZgLIcK5u+YeWep9XEHHVW3HEudShXbrPiGjD416u8N3ktwtum2gO8
        xSPKV0oxzwGtK22V0BdbpwSgPx1tr1Qoh2O3kC8eLgIaZyoZg/aGR/nx+B+DzAORE+R
        bVNcnaWzhPNJytg3mqqDi8s/XkcQS8WIaNwB+E+c=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1684185838046320.453113662738; Mon, 15 May 2023 14:23:58 -0700 (PDT)
Message-ID: <9f0db589-e7b4-09c0-aed2-588b2a2e1bf5@apertussolutions.com>
Date:   Mon, 15 May 2023 17:23:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
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
 <20230510012144.GA1851@quark.localdomain>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <20230510012144.GA1851@quark.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/9/23 21:21, Eric Biggers wrote:
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
> 
> SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> now?

I think others have commented as to why SHA-1 is provided.

> And if you absolutely MUST use SHA-1 despite it being insecure, please at least
> don't obfuscate it by calling it simply "SHA".

Apologies that it appears that way to you. Typically when referring to 
the family or a subset of the SHA algorithms, SHA-0, SHA-1, SHA-2, and 
SHA-3, it is generally accepted to refer to them as the "SHA 
algorithms". And this is contrasted to the SM algorithms which the TCG 
spec provides for which we have no intentions to support ourselves, 
though others are welcome to contribute.

Again, apologies for misunderstanding and thank you for taking the time 
to review the series.

v/r,
dps

