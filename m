Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458326FE74E
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjEJWkC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 May 2023 18:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJWkA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 May 2023 18:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DBC2735;
        Wed, 10 May 2023 15:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC30F6312C;
        Wed, 10 May 2023 22:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140E9C433D2;
        Wed, 10 May 2023 22:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683758397;
        bh=+AqWwn9+fY/877pxex6MDHJsojMZ3abT2CzqeEWd8mE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=WceTGqyAYViPUq556ba+XI2sffVTPPbvrBx62LzY8DFmxz52sqo18c/+u4D51IKBS
         Lrnc0NFU5nQIhA+ZNXePecHJUdyv+r7EqEr5RTJAevJ2H6/MshqItsBpqbrZeg5L6I
         ZN8hH9DKlIxVapwRQs8u5d5jvIhEGirp+ognsv+53h+2ywrEDVPT3vEL7RNypEgeJ2
         JsAwkLYDMctNnyHxL+q1QY4ooASNDb6xmQrrowSBfaNOA/e2qOnhcTZuJjGNcW3mvm
         9M9vflwnNQtUq4zyITCJgBcDUgPkkyu+pHz/YcIlRHhP0LolY60W7dVlPvWxHI8ydH
         DDgclPIehgtcg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:39:51 +0300
Message-Id: <CSIYJAGZ8ZN0.2B2UF522LLEDR@suppilovahvero>
Cc:     <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
        <James.Bottomley@hansenpartnership.com>, <luto@amacapital.net>,
        <nivedita@alum.mit.edu>, <kanth.ghatraju@oracle.com>,
        <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v6 12/14] x86: Secure Launch late initcall platform
 module
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ross Philipson" <ross.philipson@oracle.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-13-ross.philipson@oracle.com>
In-Reply-To: <20230504145023.835096-13-ross.philipson@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The Secure Launch platform module is a late init module. During the
> init call, the TPM event log is read and measurements taken in the
> early boot stub code are located. These measurements are extended
> into the TPM PCRs using the mainline TPM kernel driver.
>
> The platform module also registers the securityfs nodes to allow
> access to TXT register fields on Intel along with the fetching of
> and writing events to the late launch TPM log.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/kernel/Makefile   |   1 +
>  arch/x86/kernel/slmodule.c | 520 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 521 insertions(+)
>  create mode 100644 arch/x86/kernel/slmodule.c
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 3d2a33e..ee3fe300 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_IA32_EMULATION)	+=3D tls.o
>  obj-y				+=3D step.o
>  obj-$(CONFIG_INTEL_TXT)		+=3D tboot.o
>  obj-$(CONFIG_SECURE_LAUNCH)	+=3D slaunch.o
> +obj-$(CONFIG_SECURE_LAUNCH)	+=3D slmodule.o
>  obj-$(CONFIG_ISA_DMA_API)	+=3D i8237.o
>  obj-y				+=3D stacktrace.o
>  obj-y				+=3D cpu/
> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
> new file mode 100644
> index 0000000..70dcff5
> --- /dev/null
> +++ b/arch/x86/kernel/slmodule.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Secure Launch late validation/setup, securityfs exposure and
> + * finalization support.
> + *
> + * Copyright (c) 2022 Apertus Solutions, LLC
> + * Copyright (c) 2021 Assured Information Security, Inc.
> + * Copyright (c) 2022, Oracle and/or its affiliates.
> + *
> + * Author(s):
> + *     Daniel P. Smith <dpsmith@apertussolutions.com>
> + *     Garnet T. Grimm <grimmg@ainfosec.com>

I'm not sure what the authors list is good for in the days of Git,
and all the tags we have for commit messages.

Instead of this you could just put to the commit:

Co-developed-by: Garnet T. Grimm <grimmg@ainfosec.com>
Signed-off-by: Garnet T. Grimm <grimmg@ainfosec.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>

See:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when=
-to-use-acked-by-cc-and-co-developed-by

> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/security.h>
> +#include <linux/memblock.h>
> +#include <asm/segment.h>
> +#include <asm/sections.h>
> +#include <crypto/sha2.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
> +
> +#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)			\
> +static ssize_t txt_pub_read_u##size(unsigned int offset,		\
> +		loff_t *read_offset,					\
> +		size_t read_len,					\
> +		char __user *buf)					\

This would really deserve:

/*
 * Explain what DECLARE_TXT_PUB_READ_U is.
 */

> +{									\
> +	void __iomem *txt;						\
> +	char msg_buffer[msg_size];					\

Reverse-christmas tree order.

> +	u##size reg_value =3D 0;						\
> +	txt =3D ioremap(TXT_PUB_CONFIG_REGS_BASE,				\
> +			TXT_NR_CONFIG_PAGES * PAGE_SIZE);		\
> +	if (!txt)						\
> +		return -EFAULT;					\
> +	memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));	\
> +	iounmap(txt);							\
> +	snprintf(msg_buffer, msg_size, fmt, reg_value);			\
> +	return simple_read_from_buffer(buf, read_len, read_offset,	\
> +			&msg_buffer, msg_size);				\
> +}
> +
> +DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
> +DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
> +DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
> +
> +#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)		\
> +static ssize_t txt_##reg_name##_read(struct file *flip,			\
> +		char __user *buf, size_t read_len, loff_t *read_offset)	\
> +{									\
> +	return txt_pub_read_u##reg_size(reg_offset, read_offset,	\
> +			read_len, buf);					\
> +}									\
> +static const struct file_operations reg_name##_ops =3D {			\
> +	.read =3D txt_##reg_name##_read,					\
> +}
> +
> +DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
> +DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
> +DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
> +DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
> +DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
> +DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
> +DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
> +
> +/*
> + * Securityfs exposure
> + */
> +struct memfile {
> +	char *name;
> +	void *addr;
> +	size_t size;
> +};
> +
> +static struct memfile sl_evtlog =3D {"eventlog", 0, 0};
> +static void *txt_heap;
> +static struct txt_heap_event_log_pointer2_1_element __iomem *evtlog20;
> +static DEFINE_MUTEX(sl_evt_log_mutex);
> +
> +static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
> +			      size_t count, loff_t *pos)
> +{
> +	ssize_t size;
> +
> +	if (!sl_evtlog.addr)
> +		return 0;
> +
> +	mutex_lock(&sl_evt_log_mutex);
> +	size =3D simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
> +				       sl_evtlog.size);
> +	mutex_unlock(&sl_evt_log_mutex);
> +
> +	return size;
> +}
> +
> +static ssize_t sl_evtlog_write(struct file *file, const char __user *buf=
,
> +				size_t datalen, loff_t *ppos)
> +{
> +	ssize_t result;
> +	char *data;
> +
> +	if (!sl_evtlog.addr)
> +		return 0;
> +
> +	/* No partial writes. */
> +	result =3D -EINVAL;
> +	if (*ppos !=3D 0)
> +		goto out;
> +
> +	data =3D memdup_user(buf, datalen);
> +	if (IS_ERR(data)) {
> +		result =3D PTR_ERR(data);
> +		goto out;
> +	}
> +
> +	mutex_lock(&sl_evt_log_mutex);
> +	if (evtlog20)
> +		result =3D tpm20_log_event(evtlog20, sl_evtlog.addr,
> +					 sl_evtlog.size, datalen, data);
> +	else
> +		result =3D tpm12_log_event(sl_evtlog.addr, sl_evtlog.size,
> +					 datalen, data);
> +	mutex_unlock(&sl_evt_log_mutex);
> +
> +	kfree(data);
> +out:
> +	return result;
> +}
> +
> +static const struct file_operations sl_evtlog_ops =3D {
> +	.read =3D sl_evtlog_read,
> +	.write =3D sl_evtlog_write,
> +	.llseek	=3D default_llseek,
> +};
> +
> +struct sfs_file {
> +	const char *name;
> +	const struct file_operations *fops;
> +};
> +
> +#define SL_TXT_ENTRY_COUNT	7
> +static const struct sfs_file sl_txt_files[] =3D {
> +	{ "sts", &sts_ops },
> +	{ "ests", &ests_ops },
> +	{ "errorcode", &errorcode_ops },
> +	{ "didvid", &didvid_ops },
> +	{ "ver_emif", &ver_emif_ops },
> +	{ "scratchpad", &scratchpad_ops },
> +	{ "e2sts", &e2sts_ops }
> +};
> +
> +/* sysfs file handles */
> +static struct dentry *slaunch_dir;
> +static struct dentry *event_file;
> +static struct dentry *txt_dir;
> +static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
> +
> +static long slaunch_expose_securityfs(void)
> +{
> +	long ret =3D 0;
> +	int i;
> +
> +	slaunch_dir =3D securityfs_create_dir("slaunch", NULL);
> +	if (IS_ERR(slaunch_dir))
> +		return PTR_ERR(slaunch_dir);
> +
> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +		txt_dir =3D securityfs_create_dir("txt", slaunch_dir);
> +		if (IS_ERR(txt_dir)) {
> +			ret =3D PTR_ERR(txt_dir);
> +			goto remove_slaunch;
> +		}
> +
> +		for (i =3D 0; i < ARRAY_SIZE(sl_txt_files); i++) {
> +			txt_entries[i] =3D securityfs_create_file(
> +						sl_txt_files[i].name, 0440,
> +						txt_dir, NULL,
> +						sl_txt_files[i].fops);
> +			if (IS_ERR(txt_entries[i])) {
> +				ret =3D PTR_ERR(txt_entries[i]);
> +				goto remove_files;
> +			}
> +		}
> +
> +	}
> +
> +	if (sl_evtlog.addr > 0) {
> +		event_file =3D securityfs_create_file(
> +					sl_evtlog.name, 0440,
> +					slaunch_dir, NULL,
> +					&sl_evtlog_ops);
> +		if (IS_ERR(event_file)) {
> +			ret =3D PTR_ERR(event_file);
> +			goto remove_files;
> +		}
> +	}
> +
> +	return 0;
> +
> +remove_files:
> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +		while (--i >=3D 0)
> +			securityfs_remove(txt_entries[i]);
> +		securityfs_remove(txt_dir);
> +	}
> +remove_slaunch:
> +	securityfs_remove(slaunch_dir);
> +
> +	return ret;
> +}
> +
> +static void slaunch_teardown_securityfs(void)
> +{
> +	int i;
> +
> +	securityfs_remove(event_file);
> +	if (sl_evtlog.addr) {
> +		memunmap(sl_evtlog.addr);
> +		sl_evtlog.addr =3D NULL;
> +	}
> +	sl_evtlog.size =3D 0;
> +
> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +		for (i =3D 0; i < ARRAY_SIZE(sl_txt_files); i++)
> +			securityfs_remove(txt_entries[i]);
> +
> +		securityfs_remove(txt_dir);
> +
> +		if (txt_heap) {
> +			memunmap(txt_heap);
> +			txt_heap =3D NULL;
> +		}
> +	}
> +
> +	securityfs_remove(slaunch_dir);
> +}
> +
> +static void slaunch_intel_evtlog(void __iomem *txt)
> +{
> +	struct slr_entry_log_info *log_info;
> +	struct txt_os_mle_data *params;
> +	struct slr_table *slrt;
> +	void *os_sinit_data;
> +	u64 base, size;
> +
> +	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
> +	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
> +
> +	/* now map TXT heap */
> +	txt_heap =3D memremap(base, size, MEMREMAP_WB);
> +	if (!txt_heap)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap TXT heap\n",
> +			SL_ERROR_HEAP_MAP);
> +
> +	params =3D (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
> +
> +	/* Get the SLRT and remap it */
> +	slrt =3D memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
> +	if (!slrt)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap SLR Table\n",
> +			SL_ERROR_SLRT_MAP);
> +	size =3D slrt->size;
> +	memunmap(slrt);
> +
> +	slrt =3D memremap(params->slrt, size, MEMREMAP_WB);
> +	if (!slrt)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap SLR Table\n",
> +			SL_ERROR_SLRT_MAP);
> +
> +	log_info =3D (struct slr_entry_log_info *)
> +			slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
> +	if (!log_info)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap SLR Table\n",
> +			SL_ERROR_SLRT_MISSING_ENTRY);
> +
> +	sl_evtlog.size =3D log_info->size;
> +	sl_evtlog.addr =3D memremap(log_info->addr, log_info->size,
> +				  MEMREMAP_WB);
> +	if (!sl_evtlog.addr)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap TPM event log\n",
> +			SL_ERROR_EVENTLOG_MAP);
> +
> +	memunmap(slrt);
> +
> +	/* Determine if this is TPM 1.2 or 2.0 event log */
> +	if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
> +		    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
> +		return; /* looks like it is not 2.0 */
> +
> +	/* For TPM 2.0 logs, the extended heap element must be located */
> +	os_sinit_data =3D txt_os_sinit_data_start(txt_heap);
> +
> +	evtlog20 =3D tpm20_find_log2_1_element(os_sinit_data);
> +
> +	/*
> +	 * If this fails, things are in really bad shape. Any attempt to write
> +	 * events to the log will fail.
> +	 */
> +	if (!evtlog20)
> +		slaunch_txt_reset(txt,
> +			"Error failed to find TPM20 event log element\n",
> +			SL_ERROR_TPM_INVALID_LOG20);
> +}
> +
> +static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iome=
m *txt,
> +				       struct tcg_pcr_event2_head *event)
> +{
> +	u16 *alg_id_field =3D (u16 *)((u8 *)event +
> +				    sizeof(struct tcg_pcr_event2_head));
> +	struct tpm_digest *digests;
> +	u8 *dptr;
> +	int ret;
> +	u32 i, j;
> +
> +	digests =3D kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
> +			  GFP_KERNEL);
> +	if (!digests)
> +		slaunch_txt_reset(txt,
> +			"Failed to allocate array of digests\n",
> +			SL_ERROR_GENERIC);
> +
> +	for (i =3D 0; i < tpm->nr_allocated_banks; i++)
> +		digests[i].alg_id =3D tpm->allocated_banks[i].alg_id;
> +
> +
> +	/* Early SL code ensured there was a max count of 2 digests */
> +	for (i =3D 0; i < event->count; i++) {
> +		dptr =3D (u8 *)alg_id_field + sizeof(u16);
> +
> +		for (j =3D 0; j < tpm->nr_allocated_banks; j++) {
> +			if (digests[j].alg_id !=3D *alg_id_field)
> +				continue;
> +
> +			switch (digests[j].alg_id) {
> +			case TPM_ALG_SHA256:
> +				memcpy(&digests[j].digest[0], dptr,
> +				       SHA256_DIGEST_SIZE);
> +				alg_id_field =3D (u16 *)((u8 *)alg_id_field +
> +					SHA256_DIGEST_SIZE + sizeof(u16));
> +				break;
> +			case TPM_ALG_SHA1:
> +				memcpy(&digests[j].digest[0], dptr,
> +				       SHA1_DIGEST_SIZE);
> +				alg_id_field =3D (u16 *)((u8 *)alg_id_field +
> +					SHA1_DIGEST_SIZE + sizeof(u16));
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +
> +	ret =3D tpm_pcr_extend(tpm, event->pcr_idx, digests);
> +	if (ret) {
> +		pr_err("Error extending TPM20 PCR, result: %d\n", ret);
> +		slaunch_txt_reset(txt,
> +			"Failed to extend TPM20 PCR\n",
> +			SL_ERROR_TPM_EXTEND);
> +	}
> +
> +	kfree(digests);
> +}
> +
> +static void slaunch_tpm20_extend(struct tpm_chip *tpm, void __iomem *txt=
)
> +{
> +	struct tcg_pcr_event *event_header;
> +	struct tcg_pcr_event2_head *event;
> +	int start =3D 0, end =3D 0, size;
> +
> +	event_header =3D (struct tcg_pcr_event *)(sl_evtlog.addr +
> +						evtlog20->first_record_offset);
> +
> +	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
> +	event =3D (struct tcg_pcr_event2_head *)((u8 *)event_header +
> +						sizeof(struct tcg_pcr_event) +
> +						event_header->event_size);
> +
> +	while ((void  *)event < sl_evtlog.addr + evtlog20->next_record_offset) =
{
> +		size =3D __calc_tpm2_event_size(event, event_header, false);
> +		if (!size)
> +			slaunch_txt_reset(txt,
> +				"TPM20 invalid event in event log\n",
> +				SL_ERROR_TPM_INVALID_EVENT);
> +
> +		/*
> +		 * Marker events indicate where the Secure Launch early stub
> +		 * started and ended adding post launch events.
> +		 */
> +		if (event->event_type =3D=3D TXT_EVTYPE_SLAUNCH_END) {
> +			end =3D 1;
> +			break;
> +		} else if (event->event_type =3D=3D TXT_EVTYPE_SLAUNCH_START) {
> +			start =3D 1;
> +			goto next;
> +		}
> +
> +		if (start)
> +			slaunch_tpm20_extend_event(tpm, txt, event);
> +
> +next:
> +		event =3D (struct tcg_pcr_event2_head *)((u8 *)event + size);
> +	}
> +
> +	if (!start || !end)
> +		slaunch_txt_reset(txt,
> +			"Missing start or end events for extending TPM20 PCRs\n",
> +			SL_ERROR_TPM_EXTEND);
> +}
> +
> +static void slaunch_tpm12_extend(struct tpm_chip *tpm, void __iomem *txt=
)
> +{
> +	struct tpm12_event_log_header *event_header;
> +	struct tcg_pcr_event *event;
> +	struct tpm_digest digest;
> +	int start =3D 0, end =3D 0;
> +	int size, ret;
> +
> +	event_header =3D (struct tpm12_event_log_header *)sl_evtlog.addr;
> +	event =3D (struct tcg_pcr_event *)((u8 *)event_header +
> +				sizeof(struct tpm12_event_log_header));
> +
> +	while ((void  *)event < sl_evtlog.addr + event_header->next_event_offse=
t) {
> +		size =3D sizeof(struct tcg_pcr_event) + event->event_size;
> +
> +		/*
> +		 * Marker events indicate where the Secure Launch early stub
> +		 * started and ended adding post launch events.
> +		 */
> +		if (event->event_type =3D=3D TXT_EVTYPE_SLAUNCH_END) {
> +			end =3D 1;
> +			break;
> +		} else if (event->event_type =3D=3D TXT_EVTYPE_SLAUNCH_START) {
> +			start =3D 1;
> +			goto next;
> +		}
> +
> +		if (start) {
> +			memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
> +			digest.alg_id =3D TPM_ALG_SHA1;
> +			memcpy(&digest.digest[0], &event->digest[0],
> +			       SHA1_DIGEST_SIZE);
> +
> +			ret =3D tpm_pcr_extend(tpm, event->pcr_idx, &digest);
> +			if (ret) {
> +				pr_err("Error extending TPM12 PCR, result: %d\n", ret);
> +				slaunch_txt_reset(txt,
> +					"Failed to extend TPM12 PCR\n",
> +					SL_ERROR_TPM_EXTEND);
> +			}
> +		}
> +
> +next:
> +		event =3D (struct tcg_pcr_event *)((u8 *)event + size);
> +	}
> +
> +	if (!start || !end)
> +		slaunch_txt_reset(txt,
> +			"Missing start or end events for extending TPM12 PCRs\n",
> +			SL_ERROR_TPM_EXTEND);
> +}
> +
> +static void slaunch_pcr_extend(void __iomem *txt)
> +{
> +	struct tpm_chip *tpm;
> +
> +	tpm =3D tpm_default_chip();
> +	if (!tpm)
> +		slaunch_txt_reset(txt,
> +			"Could not get default TPM chip\n",
> +			SL_ERROR_TPM_INIT);
> +	if (evtlog20)
> +		slaunch_tpm20_extend(tpm, txt);
> +	else
> +		slaunch_tpm12_extend(tpm, txt);
> +}
> +
> +static int __init slaunch_module_init(void)
> +{
> +	void __iomem *txt;
> +
> +	/* Check to see if Secure Launch happened */
> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=3D
> +	    (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT))
> +		return 0;
> +
> +	txt =3D ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
> +		      PAGE_SIZE);
> +	if (!txt)
> +		panic("Error ioremap of TXT priv registers\n");
> +
> +	/* Only Intel TXT is supported at this point */
> +	slaunch_intel_evtlog(txt);
> +
> +	slaunch_pcr_extend(txt);
> +
> +	iounmap(txt);

I would remove the empty lines in-between the three calls above.

> +
> +	return slaunch_expose_securityfs();
> +}
> +
> +static void __exit slaunch_module_exit(void)
> +{
> +	slaunch_teardown_securityfs();
> +}
> +
> +late_initcall(slaunch_module_init);
> +

I would remove this empty line.

> +__exitcall(slaunch_module_exit);
> --=20
> 1.8.3.1


BR, Jarkko
