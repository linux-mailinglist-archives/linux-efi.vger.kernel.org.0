Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852A839B7E9
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jun 2021 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFDLae (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Jun 2021 07:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230136AbhFDLad (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Jun 2021 07:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622806126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9JlDk2HXRpq+0Yz9Nhh2pEWG9N+2ttsSNHw0y4E3f+k=;
        b=Ko5uVNBwtzQgW/2KnYycN53wlsTqJVrKAUEfKOIb+/J5DjSo+AwfqGbwqQ0OdovW8IZ62X
        8VZ8+hu+nmEObgNsdqCHvaELlLFeHv0iitA17Mc75SuZwFh62bUlYeX1DmG9LbPgyKg9JU
        ZWOheCWnBltmHqfwZxOarrpT1aEPw1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-N8QlJu15MRiiMx2LncVKfQ-1; Fri, 04 Jun 2021 07:28:42 -0400
X-MC-Unique: N8QlJu15MRiiMx2LncVKfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 078BE1083E94;
        Fri,  4 Jun 2021 11:28:39 +0000 (UTC)
Received: from localhost (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0209960C17;
        Fri,  4 Jun 2021 11:28:34 +0000 (UTC)
Date:   Fri, 4 Jun 2021 13:28:33 +0200
From:   Sergio Lopez <slp@redhat.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
Message-ID: <20210604112833.poejnvqchjtp4wns@mhamilton>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="taqeb7q6ydrmwa3u"
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-22-brijesh.singh@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--taqeb7q6ydrmwa3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 09:04:15AM -0500, Brijesh Singh wrote:
> Version 2 of GHCB specification provides NAEs that can be used by the SNP
> guest to communicate with the PSP without risk from a malicious hypervisor
> who wishes to read, alter, drop or replay the messages sent.
>=20
> The hypervisor uses the SNP_GUEST_REQUEST command interface provided by
> the SEV-SNP firmware to forward the guest messages to the PSP.
>=20
> In order to communicate with the PSP, the guest need to locate the secrets
> page inserted by the hypervisor during the SEV-SNP guest launch. The
> secrets page contains the communication keys used to send and receive the
> encrypted messages between the guest and the PSP.
>=20
> The secrets page is located either through the setup_data cc_blob_address
> or EFI configuration table.
>=20
> Create a platform device that the SNP guest driver can bind to get the
> platform resources. The SNP guest driver can provide userspace interface
> to get the attestation report, key derivation etc.
>=20
> The helper snp_issue_guest_request() will be used by the drivers to
> send the guest message request to the hypervisor. The guest message header
> contains a message count. The message count is used in the IV. The
> firmware increments the message count by 1, and expects that next message
> will be using the incremented count.
>=20
> The helper snp_msg_seqno() will be used by driver to get and message
> sequence counter, and it will be automatically incremented by the
> snp_issue_guest_request(). The incremented value is be saved in the
> secrets page so that the kexec'ed kernel knows from where to begin.
>=20
> See SEV-SNP and GHCB spec for more details.
>=20
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev.h      |  12 +++
>  arch/x86/include/uapi/asm/svm.h |   2 +
>  arch/x86/kernel/sev.c           | 176 ++++++++++++++++++++++++++++++++
>  arch/x86/platform/efi/efi.c     |   2 +
>  include/linux/efi.h             |   1 +
>  include/linux/sev-guest.h       |  76 ++++++++++++++
>  6 files changed, 269 insertions(+)
>  create mode 100644 include/linux/sev-guest.h
>=20
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 640108402ae9..da2f757cd9bc 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -59,6 +59,18 @@ extern void vc_no_ghcb(void);
>  extern void vc_boot_ghcb(void);
>  extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
> =20
> +/* AMD SEV Confidential computing blob structure */
> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
> +struct cc_blob_sev_info {
> +	u32 magic;
> +	u16 version;
> +	u16 reserved;
> +	u64 secrets_phys;
> +	u32 secrets_len;
> +	u64 cpuid_phys;
> +	u32 cpuid_len;
> +};
> +
>  /* Software defined (when rFlags.CF =3D 1) */
>  #define PVALIDATE_FAIL_NOUPDATE		255
> =20
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/=
svm.h
> index c0152186a008..bd64f2b98ac7 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -109,6 +109,7 @@
>  #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
>  #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
>  #define SVM_VMGEXIT_PSC				0x80000010
> +#define SVM_VMGEXIT_GUEST_REQUEST		0x80000011
>  #define SVM_VMGEXIT_AP_CREATION			0x80000013
>  #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
>  #define SVM_VMGEXIT_AP_CREATE			1
> @@ -222,6 +223,7 @@
>  	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
>  	{ SVM_VMGEXIT_PSC,		"vmgexit_page_state_change" }, \
>  	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
> +	{ SVM_VMGEXIT_GUEST_REQUEST,	"vmgexit_guest_request" }, \
>  	{ SVM_EXIT_ERR,         "invalid_guest_state" }
> =20
> =20
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 8f7ef35a25ef..8aae1166f52e 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -9,6 +9,7 @@
> =20
>  #define pr_fmt(fmt)	"SEV-ES: " fmt
> =20
> +#include <linux/platform_device.h>
>  #include <linux/sched/debug.h>	/* For show_regs() */
>  #include <linux/percpu-defs.h>
>  #include <linux/mem_encrypt.h>
> @@ -16,10 +17,13 @@
>  #include <linux/printk.h>
>  #include <linux/mm_types.h>
>  #include <linux/set_memory.h>
> +#include <linux/sev-guest.h>
>  #include <linux/memblock.h>
>  #include <linux/kernel.h>
> +#include <linux/efi.h>
>  #include <linux/mm.h>
>  #include <linux/cpumask.h>
> +#include <linux/io.h>
> =20
>  #include <asm/cpu_entry_area.h>
>  #include <asm/stacktrace.h>
> @@ -33,6 +37,7 @@
>  #include <asm/smp.h>
>  #include <asm/cpu.h>
>  #include <asm/apic.h>
> +#include <asm/setup.h>		/* For struct boot_params */
> =20
>  #include "sev-internal.h"
> =20
> @@ -47,6 +52,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __ali=
gned(PAGE_SIZE);
>   */
>  static struct ghcb __initdata *boot_ghcb;
> =20
> +static unsigned long snp_secrets_phys;
> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -105,6 +112,10 @@ struct ghcb_state {
>  	struct ghcb *ghcb;
>  };
> =20
> +#ifdef CONFIG_EFI
> +extern unsigned long cc_blob_phys;
> +#endif
> +
>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
> =20
> @@ -1909,3 +1920,168 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *r=
egs)
>  	while (true)
>  		halt();
>  }
> +
> +static struct resource guest_req_res[0];
> +static struct platform_device guest_req_device =3D {
> +	.name		=3D "snp-guest",
> +	.id		=3D -1,
> +	.resource	=3D guest_req_res,
> +	.num_resources	=3D 1,
> +};

Perhaps I'm missing something, but I can't find where the memory for
"guest_req_res" is allocated. In my tests I had to turn this
zero-length array into a single struct to prevent the kernel from
crashing.

Thanks,
Sergio.

--taqeb7q6ydrmwa3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAmC6DmEACgkQ9GknjS8M
AjUFoA/+IrYKJWSfbZbq0p0d37bRCDQdxKuwCA5d4z9spAkWPRBo9rTbVpR7w9o+
qr3PHMb920L4ZDtppUk8cqazsG52OXd6Jb0pugiGbYWbO8dmLC1STKuLqnQzVdS+
1QwBeRpgjVOxpf8oh9NdpI3J7XVpJsAdTCwrp/HFNpjZRd0lW/kE2nLMUqzmO6bi
cNIWdk73I/spC8GL3VZFf/JkbRk14eT9LGxYcqghBuClk90FPUYAbvF6Y7bBxy2U
7KLBgpcOZs+iSLWSPwRnehLLLrncvk2HqvSHwCLj3d7e1jhUiFF6xJL0wTj1gS/Z
F+dyvZD/BX/iDIehtGZr+U2kr5gD2mEF9/epJV2FL8jBcOkAxrFoG2udtIqji+pi
OkvQvpytNR46M6OWPh0axet83xb6OO3YR7Ongr6jONkEArQoS8xthEtNBZTCFKAU
+kMPsq5nvaQ2s12u0zpFqOlSCZFkcKVziPARHMdgpE/K7t7i+H8a5ykMiDlbZzGK
l4H6jW2L0fjcf/8lXXXH5AsizfSNnHcWca/CqoKgPcRAsUI/YSGdgWnEhwUEFNht
3DOaPdpOAOVD4Q0G0QNRnT3Cuh1LPEPWUARPD8UsFaN1ZPlW1g1qrp4VXsJDkww+
Aw2F9NZvRsy8hqnc8BDF+Tr1rqwl+skd+h0bG5fIDa3zlMjVwrg=
=3qjK
-----END PGP SIGNATURE-----

--taqeb7q6ydrmwa3u--

