Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974F81957DE
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 14:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0NTL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 09:19:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgC0NTL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Mar 2020 09:19:11 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 202EF426DB9E39C1A150;
        Fri, 27 Mar 2020 13:19:10 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 27 Mar 2020 13:19:09 +0000
Received: from localhost (10.47.90.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 27 Mar
 2020 13:19:09 +0000
Date:   Fri, 27 Mar 2020 13:19:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <linux-efi@vger.kernel.org>,
        <will@kernel.org>
Subject: Re: [PATCH 0/2] efi/arm64: execute the kernel in place if possible
Message-ID: <20200327131900.000068aa@Huawei.com>
In-Reply-To: <20200326165905.2240-1-ardb@kernel.org>
References: <20200326165905.2240-1-ardb@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.231]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 26 Mar 2020 17:59:03 +0100
Ard Biesheuvel <ardb@kernel.org> wrote:

> Update the relocation logic in the EFI stub for arm64 so it runs the
> kernel in place if it was loaded by firmware at an address which allows
> doing so. Then, update the PE/COFF header metadata and increase the
> section alignment to force the UEFI image loader to honour the minimal
> alignment requirement imposed by the kernel proper.
> 
> Ard Biesheuvel (2):
>   efi/libstub/arm64: avoid copying the kernel unnecessarily
>   efi/arm64: increase the PE/COFF alignment so the kernel can run in
>     place
> 
>  arch/arm64/kernel/efi-header.S            | 2 +-
>  arch/arm64/kernel/image-vars.h            | 7 +++++++
>  drivers/firmware/efi/libstub/arm64-stub.c | 9 +++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
Hi Ard.

Seems sensible to me so I decided to give it a quick test.
As things stand RELOCATABLE is only selectable by selecting
RANDOMIZE_BASE.   Probably want to be able to configure it
separately (needs some help text, or a specific option to
select CONFIG_RELOCATABLE).

Otherwise, superficially seems to work good for me doing a
boot via pxe/grub on a Kunpeng 920 with some prints added to
make sure it's taking the right paths.

Thanks,

Jonathan



