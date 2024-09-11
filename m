Return-Path: <linux-efi+bounces-1702-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE6975114
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 13:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500482817AB
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD93185B6F;
	Wed, 11 Sep 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIHVCcaK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FB1537C9;
	Wed, 11 Sep 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055476; cv=none; b=sj/G2O889RRkLMRcx/rQ3S0OVDaeRaczBM3tzf8bozTkiYkFpLByUS7MCNY4GW7ZdsAcC27Ym5VnkZ9s+huAjIXtgYVoVrm3ZlFcP+HihVjF11PyrdkxAcVU3Ma9pAniBIClUR9hZFreufgSJmikbq+BBas4MMdiHBIjFiG6ZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055476; c=relaxed/simple;
	bh=VcRhp8593HorVnJcoMR5P9X1KIpUuGKL1andDHcc1Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0Y18ZaiK2mZkxl11i7ZldWxX9BalDyGle6KUeiANIH+iToZ2SsI5C+dTPNHXaoUIrUBEA4ZQAtpUI3wQNqLAPDfeDilDgyw7tY426FdMygKcoamUyhbt4JZtPm50lkq4IbtsLrOvTOXk4Y9OS4+rfAbDuw0FwDL7zXy0bWV1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIHVCcaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED287C4CECF;
	Wed, 11 Sep 2024 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726055476;
	bh=VcRhp8593HorVnJcoMR5P9X1KIpUuGKL1andDHcc1Hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MIHVCcaKsa/zc981NiZjWwhlyj8GlC14BFiTWuoRMESHKnbYNJGqutrVX0nPqlxB1
	 5Afwg7242KCcXd5anOcaTlzPcKxNhLdxUXphlJNtV9YD0gIZLuI6nO09cLiQjzaxiP
	 5ZWfby9vuP1+upPnES1+8k1tiveYjVw+u8Yp/C8YL20V0v90TjbXY3ZgR5QgXa0Wv+
	 JER5a2WNkNkX47RcufzOW4swU2XjR8bdhCVsamHeniAbyobpjeR323iE7XFsP84pAY
	 8HdI4wBbHCxNmko+zowE18fZpuwrnivCSQuIBpdw5wYdabTNH26KFzpjbqTEvBa+t9
	 94Et/eMvgK9rA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f753375394so47805361fa.0;
        Wed, 11 Sep 2024 04:51:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB3/20lolXU260HK3SlABpnVj6bWA8IlNLkkCzpc14Bd1r7Vd+clkjlQLBVWIupWJ4vx6cCzyYMSoe+Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HqKCh3V3ful/4AEZyXJkopQLR2upOwAFG72bAA3nm0YscVZW
	yFRlNgjcgocAV7pbrM9MA7S3nE0V8fXTLKVsDgi1PUO7uHXeQ53v5jpZLBgw/Hu3beVEEcZnVbD
	5hSfxrkrQYF6f7sRz0wncJigKpEM=
X-Google-Smtp-Source: AGHT+IGwbhZjGqOj6sOlVvxEtdzPPBl7wj7LtWnVpMe6yBubbv7XFzPAcVcy/8ieGc+uRemrmEZv58Pc2Xmv81kF6a0=
X-Received: by 2002:a05:651c:2212:b0:2f6:9787:5fc0 with SMTP id
 38308e7fff4ca-2f751faa255mr103181591fa.40.1726055474181; Wed, 11 Sep 2024
 04:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
In-Reply-To: <20240911104109.1831501-1-usamaarif642@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 11 Sep 2024 13:51:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
Message-ID: <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	leitao@debian.org, rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Sept 2024 at 12:41, Usama Arif <usamaarif642@gmail.com> wrote:
>
> Looking at the TPM spec [1]
>
> If the ACPI TPM2 table contains the address and size of the Platform
> Firmware TCG log, firmware =E2=80=9Cpins=E2=80=9D the memory associated w=
ith the
> Platform FirmwareTCG log, and reports this memory as =E2=80=9CReserved=E2=
=80=9D memory
> via the INT 15h/E820 interface.
>
> It looks like the firmware should pass this as reserved in e820 memory
> map. However, it doesn't seem to. The firmware being tested on is:
> dmidecode -s bios-version
> edk2-20240214-2.el9
>
> When this area is not reserved, it comes up as usable in
> /sys/firmware/memmap. This means that kexec, which uses that memmap
> to find usable memory regions, can select the region where efi.tpm_log
> is and overwrite it and relocate_kernel.
>
> Having a fix in firmware can be difficult to get through. As a secondary
> fix, this patch marks that region as reserved in e820_table_firmware if i=
t
> is currently E820_TYPE_RAM so that kexec doesn't use it for kernel segmen=
ts.
>
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatfor=
m_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

I would expect the EFI memory map to E820 conversion implemented in
the EFI stub to take care of this.

If you are not booting via the EFI stub, the bootloader is performing
this conversion, and so it should be done there instead.


> ---
>  arch/x86/include/asm/e820/api.h | 2 ++
>  arch/x86/kernel/e820.c          | 6 ++++++
>  arch/x86/platform/efi/efi.c     | 9 +++++++++
>  drivers/firmware/efi/tpm.c      | 2 +-
>  include/linux/efi.h             | 7 +++++++
>  5 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/=
api.h
> index 2e74a7f0e935..4e9aa24f03bd 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e=
820_type type);
>
>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type)=
;
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_t=
ype, enum e820_type new_type);
> +extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_t=
ype old_type,
> +                                       enum e820_type new_type);
>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_t=
ype, bool check_type);
>  extern u64  e820__range_update_table(struct e820_table *t, u64 start, u6=
4 size, enum e820_type old_type, enum e820_type new_type);
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 4893d30ce438..912400161623 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_tabl=
e *t, u64 start, u64 size,
>         return __e820__range_update(t, start, size, old_type, new_type);
>  }
>
> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_ty=
pe old_type,
> +                                      enum e820_type new_type)
> +{
> +       return __e820__range_update(e820_table_firmware, start, size, old=
_type, new_type);
> +}
> +
>  /* Remove a range of memory from the E820 table: */
>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_ty=
pe, bool check_type)
>  {
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 88a96816de9a..aa95f77d7a30 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -171,6 +171,15 @@ static void __init do_add_efi_memmap(void)
>         e820__update_table(e820_table);
>  }
>
> +/* Reserve firmware area if it was marked as RAM */
> +void arch_update_firmware_area(u64 addr, u64 size)
> +{
> +       if (e820__get_entry_type(addr, addr + size) =3D=3D E820_TYPE_RAM)=
 {
> +               e820__range_update_firmware(addr, size, E820_TYPE_RAM, E8=
20_TYPE_RESERVED);
> +               e820__update_table(e820_table_firmware);
> +       }
> +}
> +
>  /*
>   * Given add_efi_memmap defaults to 0 and there is no alternative
>   * e820 mechanism for soft-reserved memory, import the full EFI memory
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index e8d69bd548f3..8e6e7131d718 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -60,6 +60,7 @@ int __init efi_tpm_eventlog_init(void)
>         }
>
>         tbl_size =3D sizeof(*log_tbl) + log_tbl->size;
> +       arch_update_firmware_area(efi.tpm_log, tbl_size);
>         memblock_reserve(efi.tpm_log, tbl_size);
>
>         if (efi.tpm_final_log =3D=3D EFI_INVALID_TABLE_ADDR) {
> @@ -107,4 +108,3 @@ int __init efi_tpm_eventlog_init(void)
>         early_memunmap(log_tbl, sizeof(*log_tbl));
>         return ret;
>  }
> -
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6bf3c4fe8511..9c239cdff771 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1371,4 +1371,11 @@ extern struct blocking_notifier_head efivar_ops_nh=
;
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
>
> +#ifdef CONFIG_X86_64
> +void __init arch_update_firmware_area(u64 addr, u64 size);
> +#else
> +static inline void __init arch_update_firmware_area(u64 addr, u64 size)
> +{
> +}
> +#endif
>  #endif /* _LINUX_EFI_H */
> --
> 2.43.5
>

