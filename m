Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B62703F78
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbjEOVQI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 17:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244356AbjEOVQH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 17:16:07 -0400
Received: from sender3-of-o59.zoho.com (sender3-of-o59.zoho.com [136.143.184.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3024A256;
        Mon, 15 May 2023 14:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684185320; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=G/YHsvj6/b/7CAFV2mUx8G2APTL3FuWMoufRrCO7kCXu1zNMPCx6atooXg2cN8530h0MQywhQ0EayF3xeY5YKLjnAxpJr8lL1NUajaB5vBEP1ZV/AsKStIEP/911jhMFhQMbUJ+C8qCkysgy16gh6t7c9iVVwsTOoOP3VpiwpwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1684185320; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=opLqZdRYHF3ys1ryY1OchQpGACCzgW4qUUvF6rqdT3c=; 
        b=YpUk6rN9GBZQjC2bIFrjqmQCUOfWscDtTcsCXqEdu/jwdJcWXY4IT4I5bCG+PGBBrfPTLKZ3XvTPQrMAko9c5B8MWx1CnInPjEeKCz311/XuuXinet/MC4UN6AiiRC2WginEECTtHYsNUel3Dtc/UdyloAShTmMVnYnv6NJd/io=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684185320;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=opLqZdRYHF3ys1ryY1OchQpGACCzgW4qUUvF6rqdT3c=;
        b=H+wJhL5QefRj2CwgFKv38emkOe4zX8bV3SyWcbHaRRyjgYFU6C6zbFqD9f9+Veon
        Ye/XC+6KrHMJbOE9p2lxX1NDXY/B5+XHt8SFNP8Wv1cyopWq5Bx7hTGVQfw5iNwY8mY
        Owii2fofpSsaFXmlehYYeDDuzt7U0aYLlCMA+iQc=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1684185318079382.6343558445345; Mon, 15 May 2023 14:15:18 -0700 (PDT)
Message-ID: <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
Date:   Mon, 15 May 2023 17:15:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Content-Language: en-US
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
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
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <20230512105554.GB14461@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 06:55, Matthew Garrett wrote:
> On Thu, May 04, 2023 at 02:50:13PM +0000, Ross Philipson wrote:
> 
>> +#define SLR_TABLE_MAGIC		0x4452544d
> 
>  From convention I'd expect this to be 0x534c5254, but not really an
> issue.

Apologies, but which convention?

>> +/* SLR defined bootloaders */
>> +#define SLR_BOOTLOADER_INVALID	0
>> +#define SLR_BOOTLOADER_GRUB	1
> 
> Oof. Having the kernel know about bootloaders has not worked out super
> well for us in the past. If someone writes a new bootloader, are they
> unable to Secure Launch any existing kernels? The pragmatic thing for
> them to do would be to just pretend they're grub, which kind of defeats
> the point of having this definition...

Actually, this is not for making the kernel know about bootloaders. This 
is dealing with the challenge created when the preamble was split for 
efi-stub, and similar use cases, where what sets up the preamble, ie. 
the bootloader, is separate from what invokes the dynamic launch, ie. 
the DLE handler. The reality is that even in the simplest implementation 
of the DLE handler, a remnant of GRUB for call back from efi-stub, there 
is information that is needed to cross the gap.

>> +} __packed;
> 
> Random nit - why are they all packed? Are there circumstances where two
> pieces of code with different assumptions about alignment will be
> looking at a single instance of a table? It doesn't seem likely we're
> going to be doing DRTM in a 32-bit firmware environment while launching
> a 64-bit kernel?

We wrote the TrenchBoot Secure Launch general spec [1] with as much 
forethought as possible for the target environments. Specifically, the 
desire is to have a common approach for x86 (Intel and AMD), Arm, and 
perhaps down the road the POWER arch. In particular, I do not believe 
there is anything in the Arm DRTM beta spec that prohibits a mixed 32/64 
bit environment. In the end it is better to for the spec to be safe for 
those environments then having to make changes to the spec later down 
the road.

[1] https://trenchboot.org/specifications/Secure_Launch/

v/r,
dps
