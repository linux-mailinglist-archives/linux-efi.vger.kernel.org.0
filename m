Return-Path: <linux-efi+bounces-3129-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E6A75846
	for <lists+linux-efi@lfdr.de>; Sun, 30 Mar 2025 03:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254E81884CF9
	for <lists+linux-efi@lfdr.de>; Sun, 30 Mar 2025 01:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B4EEB3;
	Sun, 30 Mar 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dRG80hsW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397ED2F24;
	Sun, 30 Mar 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743297266; cv=none; b=Ud1J5SrfNeqwZWt8O5b2daDeHGXj9PjdevvrCdqlNJgP+zzro63o4tUGmyLRRO/cOzSCkCRXaprsHPOeHu6LdHa7D1QIPON5m+AG/WdSC/z7vfXO6Ep6TDfDalvzCYTUePec77ImJGPQP/povr+Fd2A9Usoyclc55RA3+wHIRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743297266; c=relaxed/simple;
	bh=NJjk4aEzjPTotmsuuOjOnYRwqn1RcnR0XuMkiPEmO2c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Hj3APXv1HBc0Z38FbxZCCc1yNoibQHAHl7r0p+JLjBbASsc1z5zPZui+5Nt+fiMGLvNQpmBFKN4t+b1CPOEDF5lWtsdGZOfX7I7MkLNyTVMPbPOZEqd4wPCF+N1NRVjSvQubGIkXGiL7h7PpwOmvOXllH/tRtUpfY00ioTVvSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dRG80hsW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52U1DHVh2615696
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 29 Mar 2025 18:13:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52U1DHVh2615696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1743297205;
	bh=Yuf/0dPL8EDYIt8LEmDAzk7tX/UHLbJMePeCjp2/s9E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dRG80hsWRZPqYaHLspQwvAhajiyygRXgM5oM1moistjtcLvP99FwFeCcuWxQsqp78
	 9T+sJ1PV56vwPReVUFwF83zO2bXNQzdA/dNvdEICHX+q8mtkhpBIOOCdvg86k60ull
	 4wrPMV//HewvTULNssMWyjWFlpY+30CFjWyhaYq0c45CgR7chzDulYSOwEoKZamTvg
	 rqgtTUM2p3ao/sj9COgajivzgHH1x6wAC5WuvS0K9WxIkgSnhxNi1/57/LQ2rRQO5U
	 mfHeqtDL6XZ2i9rhHSdCQFo3cblzedkxTzCplnl3NiaebFEeURzo5v1oloD1rdXqNm
	 DXcgS91FdpHyA==
Date: Sat, 29 Mar 2025 18:13:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
CC: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v13_19/19=5D_x86/efi=3A_EFI_stu?=
 =?US-ASCII?Q?b_DRTM_launch_support_for_Secure_Launch?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250328230814.2210230-20-ross.philipson@oracle.com>
References: <20250328230814.2210230-1-ross.philipson@oracle.com> <20250328230814.2210230-20-ross.philipson@oracle.com>
Message-ID: <B41D3199-8054-4B2C-94D6-508D1DE4C8B3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 28, 2025 4:08:14 PM PDT, Ross Philipson <ross=2Ephilipson@oracle=
=2Ecom> wrote:
>This support allows the DRTM launch to be initiated after an EFI stub
>launch of the Linux kernel is done=2E This is accomplished by providing
>a handler to jump to when a Secure Launch is in progress=2E This has to b=
e
>called after the EFI stub does Exit Boot Services=2E
>
>Signed-off-by: Ross Philipson <ross=2Ephilipson@oracle=2Ecom>
>Reviewed-by: Ard Biesheuvel <ardb@kernel=2Eorg>
>---
> drivers/firmware/efi/libstub/efistub=2Eh  |  8 +++
> drivers/firmware/efi/libstub/x86-stub=2Ec | 94 +++++++++++++++++++++++++
> 2 files changed, 102 insertions(+)
>
>diff --git a/drivers/firmware/efi/libstub/efistub=2Eh b/drivers/firmware/=
efi/libstub/efistub=2Eh
>index d96d4494070d=2E=2Ebbbc4b327ce1 100644
>--- a/drivers/firmware/efi/libstub/efistub=2Eh
>+++ b/drivers/firmware/efi/libstub/efistub=2Eh
>@@ -135,6 +135,14 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
> 	*hi =3D upper_32_bits(data);
> }
>=20
>+static inline
>+void efi_set_u64_form(u32 lo, u32 hi, u64 *data)
>+{
>+	u64 upper =3D hi;
>+
>+	*data =3D lo | upper << 32;
>+}
>+
> /*
>  * Allocation types for calls to boottime->allocate_pages=2E
>  */
>diff --git a/drivers/firmware/efi/libstub/x86-stub=2Ec b/drivers/firmware=
/efi/libstub/x86-stub=2Ec
>index 863910e9eefc=2E=2E033133e7d953 100644
>--- a/drivers/firmware/efi/libstub/x86-stub=2Ec
>+++ b/drivers/firmware/efi/libstub/x86-stub=2Ec
>@@ -9,6 +9,8 @@
> #include <linux/efi=2Eh>
> #include <linux/pci=2Eh>
> #include <linux/stddef=2Eh>
>+#include <linux/slr_table=2Eh>
>+#include <linux/slaunch=2Eh>
>=20
> #include <asm/efi=2Eh>
> #include <asm/e820/types=2Eh>
>@@ -798,6 +800,93 @@ static efi_status_t efi_decompress_kernel(unsigned l=
ong *kernel_entry)
> 	return efi_adjust_memory_range_protection(addr, kernel_text_size);
> }
>=20
>+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
>+static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
>+						 struct boot_params *boot_params)
>+{
>+	struct slr_entry_intel_info *txt_info;
>+	struct slr_entry_policy *policy;
>+	bool updated =3D false;
>+	int i;
>+
>+	txt_info =3D slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
>+	if (!txt_info)
>+		return false;
>+
>+	txt_info->boot_params_addr =3D (u64)boot_params;
>+
>+	policy =3D slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
>+	if (!policy)
>+		return false;
>+
>+	for (i =3D 0; i < policy->nr_entries; i++) {
>+		if (policy->policy_entries[i]=2Eentity_type =3D=3D SLR_ET_BOOT_PARAMS)=
 {
>+			policy->policy_entries[i]=2Eentity =3D (u64)boot_params;
>+			updated =3D true;
>+			break;
>+		}
>+	}
>+
>+	/*
>+	 * If this is a PE entry into EFI stub the mocked up boot params will
>+	 * be missing some of the setup header data needed for the second stage
>+	 * of the Secure Launch boot=2E
>+	 */
>+	if (image) {
>+		struct setup_header *hdr =3D (struct setup_header *)((u8 *)image->imag=
e_base +
>+					    offsetof(struct boot_params, hdr));
>+		u64 cmdline_ptr;
>+
>+		boot_params->hdr=2Esetup_sects =3D hdr->setup_sects;
>+		boot_params->hdr=2Esyssize =3D hdr->syssize;
>+		boot_params->hdr=2Eversion =3D hdr->version;
>+		boot_params->hdr=2Eloadflags =3D hdr->loadflags;
>+		boot_params->hdr=2Ekernel_alignment =3D hdr->kernel_alignment;
>+		boot_params->hdr=2Emin_alignment =3D hdr->min_alignment;
>+		boot_params->hdr=2Exloadflags =3D hdr->xloadflags;
>+		boot_params->hdr=2Einit_size =3D hdr->init_size;
>+		boot_params->hdr=2Ekernel_info_offset =3D hdr->kernel_info_offset;
>+		efi_set_u64_form(boot_params->hdr=2Ecmd_line_ptr, boot_params->ext_cmd=
_line_ptr,
>+				 &cmdline_ptr);
>+		boot_params->hdr=2Ecmdline_size =3D strlen((const char *)cmdline_ptr);
>+	}
>+
>+	return updated;
>+}
>+
>+static void efi_secure_launch(struct boot_params *boot_params)
>+{
>+	struct slr_entry_dl_info *dlinfo;
>+	efi_guid_t guid =3D SLR_TABLE_GUID;
>+	dl_handler_func handler_callback;
>+	struct slr_table *slrt;
>+
>+	/*
>+	 * The presence of this table indicated a Secure Launch
>+	 * is being requested=2E
>+	 */
>+	slrt =3D (struct slr_table *)get_efi_config_table(guid);
>+	if (!slrt || slrt->magic !=3D SLR_TABLE_MAGIC)
>+		return;
>+
>+	/*
>+	 * Since the EFI stub library creates its own boot_params on entry, the
>+	 * SLRT and TXT heap have to be updated with this version=2E
>+	 */
>+	if (!efi_secure_launch_update_boot_params(slrt, boot_params))
>+		return;
>+
>+	/* Jump through DL stub to initiate Secure Launch */
>+	dlinfo =3D slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>+
>+	handler_callback =3D (dl_handler_func)dlinfo->dl_handler;
>+
>+	handler_callback(&dlinfo->bl_context);
>+
>+	unreachable();
>+}
>+#endif
>+
> static void __noreturn enter_kernel(unsigned long kernel_addr,
> 				    struct boot_params *boot_params)
> {
>@@ -925,6 +1014,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> 		goto fail;
> 	}
>=20
>+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
>+	/* If a Secure Launch is in progress, this never returns */
>+	efi_secure_launch(boot_params);
>+#endif
>+
> 	/*
> 	 * Call the SEV init code while still running with the firmware's
> 	 * GDT/IDT, so #VC exceptions will be handled by EFI=2E

efi_set_u64_form()?

What the heck is that? If it actually involves two u32 packed into a 64 fi=
eld, why not simply do two stores?

