Return-Path: <linux-efi+bounces-623-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208CB85E928
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 21:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416611C21255
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8779785958;
	Wed, 21 Feb 2024 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S4GTQTNH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A780610;
	Wed, 21 Feb 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547895; cv=none; b=MCcZhaXYgIMFa84xY1/0At2mS38nQqrcZJfxafHURVMzjxq2Gaqmb51s14+Cr5ifSUhlLJO/RN4XrMjD2CS2BRCVhqEWZrvBp1iZgeuDjiKMAmxnFzvi1zy93BbXX/CkcYvvmMkW/bjHVCytIq46M8kpCZLjLEovTc9NqS9Em+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547895; c=relaxed/simple;
	bh=I/DY6z8iepvKaIIyOWw2DaiZiDo7l7TREvRQVddmbhI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E1JrSsQjIl4RJQEZ8SnCVFOeywZYqo2ztQlCEbRyl5oLziW3fyFcwl/B4lUf8/GZKY3pzRY6CsLWYu3OnASXzYBoRl/Vjjxb7zFg9Ty0tRmQ+cZz0ykw12r4tzv5D5P6O1yZd0dnKrKw2BLeEvHcObIC8Ey6PYJdFppPhqTrhfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=S4GTQTNH; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41LKbSZv4150814
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 21 Feb 2024 12:37:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41LKbSZv4150814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1708547850;
	bh=wZe+pzvmKGW8dDc4NzUwS8b+P+8iJHoRmhS8844tchY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=S4GTQTNHxB+sljASMnNjXqY+w1ctwJCmRVSC4Fv0cmcDKI2n6x33I7WBfJkKvuf0d
	 pwbyJDK/EY/DM7C9BcPikhRplUIi5Rc0KPXf+IW4w+AUaszLrZ5XVcF4IobP6PBhUc
	 50R6Ico7S5fHeNBunqOw3yscrB61NHLvQ36cg4ORsc8JXCpD7jVZXUCnwGuL0vq9mM
	 EIUk5zseXyO6uLx8U/edkYY5gRrk4hLjDPwcd3KoGZsOVYnbHGLqLU0xNZBVvlXGRW
	 TxUfiX+TAEDdfpVDVNuGV24yzVhioDDhgw6Z+kR66utuOqcvzDqJC+ZtCFPaNeHKbM
	 O5Y9GBZj1Gyuw==
Date: Wed, 21 Feb 2024 12:37:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: ross.philipson@oracle.com, Ard Biesheuvel <ardb@kernel.org>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_15/15=5D_x86=3A_EFI_stub_D?= =?US-ASCII?Q?RTM_launch_support_for_Secure_Launch?=
User-Agent: K-9 Mail for Android
In-Reply-To: <dc53f100-062b-47ae-abc8-5414ce8d041c@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-16-ross.philipson@oracle.com> <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com> <dc53f100-062b-47ae-abc8-5414ce8d041c@oracle.com>
Message-ID: <C98F883A-31D5-4F67-97FF-4AEFAADDDC74@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 21, 2024 12:17:30 PM PST, ross=2Ephilipson@oracle=2Ecom wrote:
>On 2/15/24 1:01 AM, Ard Biesheuvel wrote:
>> On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross=2Ephilipson@oracle=
=2Ecom> wrote:
>>>=20
>>> This support allows the DRTM launch to be initiated after an EFI stub
>>> launch of the Linux kernel is done=2E This is accomplished by providin=
g
>>> a handler to jump to when a Secure Launch is in progress=2E This has t=
o be
>>> called after the EFI stub does Exit Boot Services=2E
>>>=20
>>> Signed-off-by: Ross Philipson <ross=2Ephilipson@oracle=2Ecom>
>>> ---
>>>   drivers/firmware/efi/libstub/x86-stub=2Ec | 55 +++++++++++++++++++++=
++++
>>>   1 file changed, 55 insertions(+)
>>>=20
>>> diff --git a/drivers/firmware/efi/libstub/x86-stub=2Ec b/drivers/firmw=
are/efi/libstub/x86-stub=2Ec
>>> index 0d510c9a06a4=2E=2E4df2cf539194 100644
>>> --- a/drivers/firmware/efi/libstub/x86-stub=2Ec
>>> +++ b/drivers/firmware/efi/libstub/x86-stub=2Ec
>>> @@ -9,6 +9,7 @@
>>>   #include <linux/efi=2Eh>
>>>   #include <linux/pci=2Eh>
>>>   #include <linux/stddef=2Eh>
>>> +#include <linux/slr_table=2Eh>
>>>=20
>>>   #include <asm/efi=2Eh>
>>>   #include <asm/e820/types=2Eh>
>>> @@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsigne=
d long *kernel_entry)
>>>          return EFI_SUCCESS;
>>>   }
>>>=20
>>> +static void efi_secure_launch(struct boot_params *boot_params)
>>> +{
>>> +       struct slr_entry_uefi_config *uefi_config;
>>> +       struct slr_uefi_cfg_entry *uefi_entry;
>>> +       struct slr_entry_dl_info *dlinfo;
>>> +       efi_guid_t guid =3D SLR_TABLE_GUID;
>>> +       struct slr_table *slrt;
>>> +       u64 memmap_hi;
>>> +       void *table;
>>> +       u8 buf[64] =3D {0};
>>> +
>>=20
>> If you add a flex array to slr_entry_uefi_config as I suggested in
>> response to the other patch, we could simplify this substantially
>
>I feel like there is some reason why we did not use flex arrays=2E We wer=
e talking and we seem to remember we used to use them and someone asked us =
to remove them=2E We are still looking into it=2E But if we can go back to =
them, I will take all the changes you recommended here=2E
>
>Thanks
>Ross
>
>>=20
>> static struct slr_entry_uefi_config cfg =3D {
>>          =2Ehdr=2Etag        =3D SLR_ENTRY_UEFI_CONFIG,
>>          =2Ehdr=2Esize       =3D sizeof(cfg),
>>          =2Erevision       =3D SLR_UEFI_CONFIG_REVISION,
>>          =2Enr_entries     =3D 1,
>>          =2Eentries[0]     =3D {
>>                  =2Epcr    =3D 18,
>>                  =2Eevt_info =3D "Measured UEFI memory map",
>>          },
>> };
>>=20
>> cfg=2Eentries[0]=2Ecfg  =3D boot_params->efi_info=2Eefi_memmap |
>>                        (u64)boot_params->efi_info=2Eefi_memmap_hi << 32=
;
>> cfg=2Eentries[0]=2Esize =3D boot_params->efi_info=2Eefi_memmap_size;
>>=20
>>=20
>>=20
>>> +       table =3D get_efi_config_table(guid);
>>> +
>>> +       /*
>>> +        * The presence of this table indicated a Secure Launch
>>> +        * is being requested=2E
>>> +        */
>>> +       if (!table)
>>> +               return;
>>> +
>>> +       slrt =3D (struct slr_table *)table;
>>> +
>>> +       if (slrt->magic !=3D SLR_TABLE_MAGIC)
>>> +               return;
>>> +
>>=20
>> slrt =3D (struct slr_table *)get_efi_config_table(guid);
>> if (!slrt || slrt->magic !=3D SLR_TABLE_MAGIC)
>>          return;
>>=20
>>> +       /* Add config information to measure the UEFI memory map */
>>> +       uefi_config =3D (struct slr_entry_uefi_config *)buf;
>>> +       uefi_config->hdr=2Etag =3D SLR_ENTRY_UEFI_CONFIG;
>>> +       uefi_config->hdr=2Esize =3D sizeof(*uefi_config) + sizeof(*uef=
i_entry);
>>> +       uefi_config->revision =3D SLR_UEFI_CONFIG_REVISION;
>>> +       uefi_config->nr_entries =3D 1;
>>> +       uefi_entry =3D (struct slr_uefi_cfg_entry *)(buf + sizeof(*uef=
i_config));
>>> +       uefi_entry->pcr =3D 18;
>>> +       uefi_entry->cfg =3D boot_params->efi_info=2Eefi_memmap;
>>> +       memmap_hi =3D boot_params->efi_info=2Eefi_memmap_hi;
>>> +       uefi_entry->cfg |=3D memmap_hi << 32;
>>> +       uefi_entry->size =3D boot_params->efi_info=2Eefi_memmap_size;
>>> +       memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
>>> +               strlen("Measured UEFI memory map"));
>>> +
>>=20
>> Drop all of this
>>=20
>>> +       if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))
>>=20
>> if (slr_add_entry(slrt, &uefi_config=2Ehdr))
>>=20
>>=20
>>> +               return;
>>> +
>>> +       /* Jump through DL stub to initiate Secure Launch */
>>> +       dlinfo =3D (struct slr_entry_dl_info *)
>>> +               slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>>> +
>>> +       asm volatile ("jmp *%%rax"
>>> +                     : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_c=
ontext));
>>=20
>> Fix the prototype and just do
>>=20
>> dlinfo->dl_handler(&dlinfo->bl_context);
>> unreachable();
>>=20
>>=20
>> So in summary, this becomes
>>=20
>> static void efi_secure_launch(struct boot_params *boot_params)
>> {
>>          static struct slr_entry_uefi_config cfg =3D {
>>                  =2Ehdr=2Etag        =3D SLR_ENTRY_UEFI_CONFIG,
>>                  =2Ehdr=2Esize       =3D sizeof(cfg),
>>                  =2Erevision       =3D SLR_UEFI_CONFIG_REVISION,
>>                  =2Enr_entries     =3D 1,
>>                  =2Eentries[0]     =3D {
>>                          =2Epcr    =3D 18,
>>                          =2Eevt_info =3D "Measured UEFI memory map",
>>                  },
>>          };
>>          struct slr_entry_dl_info *dlinfo;
>>          efi_guid_t guid =3D SLR_TABLE_GUID;
>>          struct slr_table *slrt;
>>=20
>>          /*
>>           * The presence of this table indicated a Secure Launch
>>           * is being requested=2E
>>           */
>>          slrt =3D (struct slr_table *)get_efi_config_table(guid);
>>          if (!slrt || slrt->magic !=3D SLR_TABLE_MAGIC)
>>                  return;
>>=20
>>          cfg=2Eentries[0]=2Ecfg  =3D boot_params->efi_info=2Eefi_memmap=
 |
>>                                (u64)boot_params->efi_info=2Eefi_memmap_=
hi << 32;
>>          cfg=2Eentries[0]=2Esize =3D boot_params->efi_info=2Eefi_memmap=
_size;
>>=20
>>          if (slr_add_entry(slrt, &cfg=2Ehdr))
>>                  return;
>>=20
>>          /* Jump through DL stub to initiate Secure Launch */
>>          dlinfo =3D (struct slr_entry_dl_info *)
>>                   slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>>=20
>>          dlinfo->dl_handler(&dlinfo->bl_context);
>>=20
>>          unreachable();
>> }
>>=20
>>=20
>>> +}
>>> +
>>>   static void __noreturn enter_kernel(unsigned long kernel_addr,
>>>                                      struct boot_params *boot_params)
>>>   {
>>> @@ -934,6 +986,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle=
,
>>>                  goto fail;
>>>          }
>>>=20
>>> +       /* If a Secure Launch is in progress, this never returns */
>>=20
>> if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
>>=20
>>> +       efi_secure_launch(boot_params);
>>> +
>>>          /*
>>>           * Call the SEV init code while still running with the firmwa=
re's
>>>           * GDT/IDT, so #VC exceptions will be handled by EFI=2E
>>> --
>>> 2=2E39=2E3
>>>=20
>>=20
>

Linux kernel code doesn't use VLAs because of the limited stack size, and =
VLAs or alloca() makes stack size tracking impossible=2E Although this tech=
nically speaking runs in a different environment, it is easier to enforce t=
he constraint globally=2E

