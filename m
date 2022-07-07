Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292E6569ED0
	for <lists+linux-efi@lfdr.de>; Thu,  7 Jul 2022 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiGGJsc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Jul 2022 05:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJsb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Jul 2022 05:48:31 -0400
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C28DF69;
        Thu,  7 Jul 2022 02:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657187276; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IeW7CmKisiJaE3pVWkI/F+5MdcngjRiLaAY1zVvmVucvGKqAP3KI50yY1wpVc5qSJtkOGqTpZkTEpmuDn9oKzJwQrL6XeKVEWmC8Cb3WY5IZdIOlaDLLnhdjpqSUHZMObhB4JsofAm+c27oYXEUM91okzF7La277sAlWgHDJ/HY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657187276; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AxgMRIxlOM7se1RN4hoSSzKpsvEX8snGSo/jMnDX/Ek=; 
        b=KBTUiCEn80z6AHIupkVuG2OQijhEML5J0n1ZUPb1eKfyKwV7YDU/Ruv0U5oPN6j8WkBOtxx7eaC27lbQdF5QV1C30jfSQMB30NBgHV9fWPfTUcJNHoTGQIRqpQJPgTb4Cj3StZY2mQnWCYUIBuVCgGftCqymIpMHe6oJWurUaJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657187276;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=AxgMRIxlOM7se1RN4hoSSzKpsvEX8snGSo/jMnDX/Ek=;
        b=bNuNz5RLnm0oVDSPCegtHT9bLWpV9KooJQzx/hs9cDw7HfHcJYg/XFxb2wrvhPBs
        IuN/dTS0HjbgUYS4kuPBAerNnc1UDtc8HSUUMAAzfgc3xaYh+Mb67J1c/fXDXR7Xxnm
        NSenPKAzT0UAOe+5hVwNwALsCBMddgv5NNyIDGYM=
Received: from [10.10.1.164] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1657187267545698.9829943472045; Thu, 7 Jul 2022 02:47:47 -0700 (PDT)
Message-ID: <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
Date:   Thu, 7 Jul 2022 05:46:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Linux DRTM on UEFI platforms
Content-Language: en-US
To:     The development of GNU GRUB <grub-devel@gnu.org>,
        Brendan Trotter <btrotter@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>
References: <20220329174057.GA17778@srcf.ucam.org>
 <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
 <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/5/22 20:03, Brendan Trotter wrote:
> Hi,

Greetings!

Not sure why I got dropped from distro, but no worries.

> On Wed, Jul 6, 2022 at 4:52 AM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>> On 6/10/22 12:40, Ard Biesheuvel wrote:> On Thu, 19 May 2022 at 22:59,
>> To help provide clarity, consider the following flows for comparison,
>>
>> Normal/existing efi-stub:
>>    EFI -> efi-stub -> head_64.S
>>
>> Proposed secure launch:
>>    EFI -> efi-stub -> dl-handler -> [cpu] -> sl_stub ->head_64.S
> 
> For more clarity; the entire point is to ensure that the kernel only
> has to trust itself and the CPU/TPM hardware (and does not have to
> trust a potentially malicious boot loader)..Any attempt to avoid a
> one-off solution for Linux is an attempt to weaken security.

Please elaborate so I might understand how this entrypoint allows for 
the kernel to only trust itself and the CPU/TPM.

> The only correct approach is "efi-stub -> head_64.S -> kernel's own
> secure init"; where (on UEFI systems) neither GRUB nor Trenchboot has
> a valid reason to exist and should never be installed.
> 
> 
> Cheers,
> 
> Brendan

v/r,
dps
