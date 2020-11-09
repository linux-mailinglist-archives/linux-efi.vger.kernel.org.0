Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8B2AAEB1
	for <lists+linux-efi@lfdr.de>; Mon,  9 Nov 2020 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgKIBTS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Nov 2020 20:19:18 -0500
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:60870 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKIBTS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 8 Nov 2020 20:19:18 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0A91Itv4020729; Mon, 9 Nov 2020 10:18:55 +0900
X-Iguazu-Qid: 34trFI5eBnsfcuv5BC
X-Iguazu-QSIG: v=2; s=0; t=1604884735; q=34trFI5eBnsfcuv5BC; m=fASxfKb7gMfbRWGtZyCx9j9NW3GRwWaYhWoTAptrXKU=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 0A91IrBI012852;
        Mon, 9 Nov 2020 10:18:53 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0A91Ir2B008158;
        Mon, 9 Nov 2020 10:18:53 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0A91Iq9M022229;
        Mon, 9 Nov 2020 10:18:52 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
        <87a6vv9hch.fsf@kokedama.swc.toshiba.co.jp>
        <20201106120950.GC14914@zn.tnic>
Date:   Mon, 09 Nov 2020 10:18:46 +0900
In-Reply-To: <20201106120950.GC14914@zn.tnic> (Borislav Petkov's message of
        "Fri, 6 Nov 2020 13:09:50 +0100")
X-TSB-HOP: ON
Message-ID: <874klz9vk9.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Fri, Nov 06, 2020 at 02:36:46PM +0900, Punit Agrawal wrote:
>> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
>> > index 2531de49f56c..438ed9eff6d0 100644
>> > --- a/drivers/firmware/efi/cper-x86.c
>> > +++ b/drivers/firmware/efi/cper-x86.c
>> > @@ -2,6 +2,7 @@
>> >  // Copyright (C) 2018, Advanced Micro Devices, Inc.
>> >  
>> >  #include <linux/cper.h>
>> > +#include <linux/acpi.h>
>> 
>> Did you mean to include <asm/acpi.h>?
>
> Why?

Because arch_apei_report_x86_error() used in the patch is defined
there. The indirect include works but pulls in additional definitions
not needed by the patch.

Do you prefer the more generic include?

Thanks,
Punit
