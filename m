Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FD733A4A
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jun 2023 22:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjFPUCU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jun 2023 16:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344428AbjFPUB6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jun 2023 16:01:58 -0400
Received: from sender3-of-o58.zoho.com (sender3-of-o58.zoho.com [136.143.184.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B31B1FF9;
        Fri, 16 Jun 2023 13:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686945673; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Aed/zMdm/a0Ego3xS007SykTRZ1uBPGmfiR7ovHozkZZfpquuf+SBMRqy0CxSSJHOQEfehym8UJ2ullyI82ueLw/Oh4CR256DpM6aq0wCm1WwUcsDwqox2LG0Gllruhumjw/bJxYWWjHOFjFCLWcqqdLw9C3jY7RCO8+wOD+TMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686945673; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=d4POYnDYEYq4KXRMXuAAYuuj2EQrVKJPKhALdERs4yU=; 
        b=NHlsO1vZcYl3mvWCl4Pyt9EfBxVkHNq0gAhH0L1VTcpCDMNuF+WJgaY2UKhzh/8OjM+cnTJzqt80HBwlOv4Y/SzCYMeRcKdGcHHP6CRRaE52mQK7/K115rZlNgfhGMyS7s0QaVcAAHarZFvBrrVXSwyHlE9vs1btcT9/JlvIDis=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686945673;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:From:From:Subject:Subject:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=d4POYnDYEYq4KXRMXuAAYuuj2EQrVKJPKhALdERs4yU=;
        b=sZPVrW+DORFJNiWvzg6tCQUEvK3+up5RgGCEt9nURrHbNLlrQiX+pUzJYY4ks5pX
        ZYV9s/f5b3ylUKE3Iv/VyAP444QANslTUmNgrdHR1il51QR6H3AncpxviBh0b40wTGP
        WGIy1byLFzuekBVvpFoLZM8TVOS4aUfW7Cfbz+a8=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1686945672512692.7552950489951; Fri, 16 Jun 2023 13:01:12 -0700 (PDT)
Message-ID: <eda6da3a-00fe-21c5-5a3d-3e06d21179f4@apertussolutions.com>
Date:   Fri, 16 Jun 2023 16:01:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
In-Reply-To: <20230516014310.GA5403@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/15/23 21:43, Matthew Garrett wrote:
> On Mon, May 15, 2023 at 08:41:00PM -0400, Daniel P. Smith wrote:
>> On 5/15/23 17:22, Matthew Garrett wrote:
>>> What if I don't use grub, but use something that behaves equivalently?
>>> Which value should be used here?
>>
>> Generally we would request that the bootloader submit a request to register
>> for a value to be reserved in the spec. That aside, the intent here is to
>> allow for the possibility for the DLE handler to be independent from the
>> bootloader, but this does not have to be this way. If a non-open entity
>> decides to produce their own implementation, they can freely use a
>> unallocated value at their own risk that it could be allocated to another
>> bootloader in the future. Though in this scenario it likely would not matter
>> as the non-open DLE handler would only be present when the non-open
>> bootloader was present.
> 
> Is the expectation that the DLE will always be shipped with the
> bootloader? I think I'm not entirely clear on what's consuming this and
> why.
> 

No, in fact, an early idea proposed by a pair of us in the TrenchBoot 
community was to have it live either as a Runtime Service that was 
loaded by a UEFI app or in the coreboot UEFI payload.
