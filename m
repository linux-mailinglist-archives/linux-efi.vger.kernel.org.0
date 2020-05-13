Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4134E1D050D
	for <lists+linux-efi@lfdr.de>; Wed, 13 May 2020 04:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgEMChA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 May 2020 22:37:00 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:56258 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEMChA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 May 2020 22:37:00 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 04D2ae54007140; Wed, 13 May 2020 11:36:40 +0900
X-Iguazu-Qid: 34trDAmeIu11rkEjys
X-Iguazu-QSIG: v=2; s=0; t=1589337400; q=34trDAmeIu11rkEjys; m=pK2KXljWZTLcH9XwqUT1Sc58njnMsc8wOqfGuj2Bpqo=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1513) id 04D2acok007719;
        Wed, 13 May 2020 11:36:39 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 04D2acj8000332;
        Wed, 13 May 2020 11:36:38 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 04D2acCb026192;
        Wed, 13 May 2020 11:36:38 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [Patch v2] efi: cper: Add support for printing Firmware Error Record Reference
References: <20200512045502.3810339-1-punit1.agrawal@toshiba.co.jp>
        <CAMj1kXGNWptRShYVtDwoB7jL1_2M1ioroFV=veFt0MB=n6_-OQ@mail.gmail.com>
Date:   Wed, 13 May 2020 11:36:37 +0900
In-Reply-To: <CAMj1kXGNWptRShYVtDwoB7jL1_2M1ioroFV=veFt0MB=n6_-OQ@mail.gmail.com>
        (Ard Biesheuvel's message of "Tue, 12 May 2020 12:47:59 +0200")
X-TSB-HOP: ON
Message-ID: <87v9l0o91m.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:

> On Tue, 12 May 2020 at 06:55, Punit Agrawal
> <punit1.agrawal@toshiba.co.jp> wrote:
>>
>> While debugging a boot failure, the following unknown error record was
>> seen in the boot logs.
>>
>>     <...>
>>     BERT: Error records from previous boot:
>>     [Hardware Error]: event severity: fatal
>>     [Hardware Error]:  Error 0, type: fatal
>>     [Hardware Error]:   section type: unknown, 81212a96-09ed-4996-9471-8d729c8e69ed
>>     [Hardware Error]:   section length: 0x290
>>     [Hardware Error]:   00000000: 00000001 00000000 00000000 00020002  ................
>>     [Hardware Error]:   00000010: 00020002 0000001f 00000320 00000000  ........ .......
>>     [Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
>>     [Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
>>     <...>
>>
>> On further investigation, it was found that the error record with
>> UUID (81212a96-09ed-4996-9471-8d729c8e69ed) has been defined in the
>> UEFI Specification at least since v2.4 and has recently had additional
>> fields defined in v2.7 Section N.2.10 Firmware Error Record Reference.
>>
>> Add support for parsing and printing the defined fields to give users
>> a chance to figure out what went wrong.
>>
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-efi@vger.kernel.org
>> ---
>> Hi Ard,
>>
>> I've updated the patch based on your feedback.
>>
>> As you noted, some aspects of the spec make it a bit tricky to support
>> all revisions in a nice way (e.g., size check) but this version should
>> fix existing issues.
>>
>> Thanks,
>> Punit
>>
>> v1[0] -> v2:
>> * Simplified error record structure definition
>> * Fixed size check
>> * Added comment to clarify offset calculation for dumped data
>> * Style fixes for multiline if blocks
>
> Thanks. I will queue this as a fix.

Thanks!

Just for my understanding - are you planning to send this for v5.7 or
v5.8? There's no rush, so I am fine either ways.

[...]

