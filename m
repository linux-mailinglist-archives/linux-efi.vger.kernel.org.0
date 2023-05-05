Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E596F89A1
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjEETmU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 15:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjEETmT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 15:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6DF1BE4;
        Fri,  5 May 2023 12:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87B563DFF;
        Fri,  5 May 2023 19:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211F7C433D2;
        Fri,  5 May 2023 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683315737;
        bh=pPOc9V+teqBWA7vYeoYZqwumUjynrfKxAGM6Xam23IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=negPFhKEVRUA/oMsrUreOofmvV3zkGIR/U1ZNa2UJtHKYdy6cdODydjA2uifqIRHX
         Tv5zoYVRbxyMd7kscJ+PRLwOic5RmA6ETS9YQnIc8+5DwSsypf6kn5RGMU2NaPW+vq
         xAmCEa6pZCvhQvlmTjk6vaxgxAkwjKEcg8pg9znEdqJx9VCXiOxlvWIGq9hPi/XGo4
         5Anv2iYfNi/SOGgC35vBemHbO19RX/YQ9+60IN6BWvTMMVGWcwchYABlQ5R/xcdLrb
         LU3bMqH3YMhF/evY2w/RxDDGxQiuGwgQqyyKsQbeq498J3O1+7yMMmJWcnSKPmQDBs
         6dAkcOCQfZwjA==
Date:   Fri, 5 May 2023 21:42:08 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 12/14] x86: Secure Launch late initcall platform module
Message-ID: <ZFVcEI0RAS5pvrAc@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-13-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-13-ross.philipson@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04, 2023 at 02:50:21PM +0000, Ross Philipson wrote:
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

Hi Ross,

a few more items from my side.

...

> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c

...

> +/*
> + * Securityfs exposure
> + */
> +struct memfile {
> +	char *name;
> +	void *addr;
> +	size_t size;
> +};
> +
> +static struct memfile sl_evtlog = {"eventlog", 0, 0};

I don't think the 0 fields are necessary above, memset will zero
any fields not explicitly set. But if you want to go that way, then
I think the first one should be NULL, as the addr field is a pointer.

> +static void *txt_heap;
> +static struct txt_heap_event_log_pointer2_1_element __iomem *evtlog20;
> +static DEFINE_MUTEX(sl_evt_log_mutex);

> +static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
> +			      size_t count, loff_t *pos)
> +{
> +	ssize_t size;
> +
> +	if (!sl_evtlog.addr)
> +		return 0;
> +
> +	mutex_lock(&sl_evt_log_mutex);
> +	size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
> +				       sl_evtlog.size);
> +	mutex_unlock(&sl_evt_log_mutex);
> +
> +	return size;
> +}
> +
> +static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
> +				size_t datalen, loff_t *ppos)

nit: the line above doesn't align to the '(' on the line before that.

> +{
> +	ssize_t result;
> +	char *data;
> +
> +	if (!sl_evtlog.addr)
> +		return 0;
> +
> +	/* No partial writes. */
> +	result = -EINVAL;
> +	if (*ppos != 0)
> +		goto out;
> +
> +	data = memdup_user(buf, datalen);
> +	if (IS_ERR(data)) {
> +		result = PTR_ERR(data);
> +		goto out;
> +	}
> +
> +	mutex_lock(&sl_evt_log_mutex);
> +	if (evtlog20)
> +		result = tpm20_log_event(evtlog20, sl_evtlog.addr,
> +					 sl_evtlog.size, datalen, data);

Sparse says that the type of the first argument of tmp20_log_event is:

	struct txt_heap_event_log_pointer2_1_element *

However, the type of evtlog20 is:

	struct txt_heap_event_log_pointer2_1_element __iomem *

> +	else
> +		result = tpm12_log_event(sl_evtlog.addr, sl_evtlog.size,
> +					 datalen, data);
> +	mutex_unlock(&sl_evt_log_mutex);
> +
> +	kfree(data);
> +out:
> +	return result;
> +}

...

> +static long slaunch_expose_securityfs(void)
> +{
> +	long ret = 0;
> +	int i;
> +
> +	slaunch_dir = securityfs_create_dir("slaunch", NULL);
> +	if (IS_ERR(slaunch_dir))
> +		return PTR_ERR(slaunch_dir);
> +
> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +		txt_dir = securityfs_create_dir("txt", slaunch_dir);
> +		if (IS_ERR(txt_dir)) {
> +			ret = PTR_ERR(txt_dir);
> +			goto remove_slaunch;
> +		}
> +
> +		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
> +			txt_entries[i] = securityfs_create_file(
> +						sl_txt_files[i].name, 0440,
> +						txt_dir, NULL,
> +						sl_txt_files[i].fops);
> +			if (IS_ERR(txt_entries[i])) {
> +				ret = PTR_ERR(txt_entries[i]);
> +				goto remove_files;
> +			}
> +		}
> +

nit: no blank line here.

> +	}
> +
> +	if (sl_evtlog.addr > 0) {

addr is a pointer. So perhaps:

	if (sl_evtlog.addr) {

> +		event_file = securityfs_create_file(
> +					sl_evtlog.name, 0440,
> +					slaunch_dir, NULL,
> +					&sl_evtlog_ops);
> +		if (IS_ERR(event_file)) {
> +			ret = PTR_ERR(event_file);
> +			goto remove_files;
> +		}
> +	}
> +
> +	return 0;
> +
> +remove_files:
> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +		while (--i >= 0)
> +			securityfs_remove(txt_entries[i]);
> +		securityfs_remove(txt_dir);
> +	}
> +remove_slaunch:
> +	securityfs_remove(slaunch_dir);
> +
> +	return ret;
> +}

...

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
> +	txt_heap = memremap(base, size, MEMREMAP_WB);
> +	if (!txt_heap)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap TXT heap\n",
> +			SL_ERROR_HEAP_MAP);

nit: These lines are not aligned to the opening '('

> +
> +	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
> +
> +	/* Get the SLRT and remap it */
> +	slrt = memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
> +	if (!slrt)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap SLR Table\n",
> +			SL_ERROR_SLRT_MAP);
> +	size = slrt->size;
> +	memunmap(slrt);
> +
> +	slrt = memremap(params->slrt, size, MEMREMAP_WB);
> +	if (!slrt)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap SLR Table\n",
> +			SL_ERROR_SLRT_MAP);
> +
> +	log_info = (struct slr_entry_log_info *)
> +			slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
> +	if (!log_info)
> +		slaunch_txt_reset(txt,
> +			"Error failed to memremap SLR Table\n",
> +			SL_ERROR_SLRT_MISSING_ENTRY);
> +
> +	sl_evtlog.size = log_info->size;
> +	sl_evtlog.addr = memremap(log_info->addr, log_info->size,
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
> +	os_sinit_data = txt_os_sinit_data_start(txt_heap);
> +

The return type of tmp20_find_lot2_1_element() is:

	struct txt_heap_event_log_pointer2_1_element *

However, the type of evtlog20 is:

	struct txt_heap_event_log_pointer2_1_element __iomem *

> +	evtlog20 = tpm20_find_log2_1_element(os_sinit_data);
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
> +static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iomem *txt,
> +				       struct tcg_pcr_event2_head *event)
> +{
> +	u16 *alg_id_field = (u16 *)((u8 *)event +
> +				    sizeof(struct tcg_pcr_event2_head));
> +	struct tpm_digest *digests;
> +	u8 *dptr;
> +	int ret;
> +	u32 i, j;
> +
> +	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
> +			  GFP_KERNEL);
> +	if (!digests)
> +		slaunch_txt_reset(txt,
> +			"Failed to allocate array of digests\n",
> +			SL_ERROR_GENERIC);
> +
> +	for (i = 0; i < tpm->nr_allocated_banks; i++)
> +		digests[i].alg_id = tpm->allocated_banks[i].alg_id;
> +
> +

nit: one blank line is enough.

> +	/* Early SL code ensured there was a max count of 2 digests */
> +	for (i = 0; i < event->count; i++) {
> +		dptr = (u8 *)alg_id_field + sizeof(u16);
> +
> +		for (j = 0; j < tpm->nr_allocated_banks; j++) {
> +			if (digests[j].alg_id != *alg_id_field)
> +				continue;
> +
> +			switch (digests[j].alg_id) {
> +			case TPM_ALG_SHA256:
> +				memcpy(&digests[j].digest[0], dptr,
> +				       SHA256_DIGEST_SIZE);
> +				alg_id_field = (u16 *)((u8 *)alg_id_field +
> +					SHA256_DIGEST_SIZE + sizeof(u16));
> +				break;
> +			case TPM_ALG_SHA1:
> +				memcpy(&digests[j].digest[0], dptr,
> +				       SHA1_DIGEST_SIZE);
> +				alg_id_field = (u16 *)((u8 *)alg_id_field +
> +					SHA1_DIGEST_SIZE + sizeof(u16));
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +
> +	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
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
> +static void slaunch_tpm20_extend(struct tpm_chip *tpm, void __iomem *txt)
> +{
> +	struct tcg_pcr_event *event_header;
> +	struct tcg_pcr_event2_head *event;
> +	int start = 0, end = 0, size;
> +
> +	event_header = (struct tcg_pcr_event *)(sl_evtlog.addr +
> +						evtlog20->first_record_offset);

Sparse says that evtlog20 shouldn't be dereferenced because it
has a __iomem attribute.

> +
> +	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
> +	event = (struct tcg_pcr_event2_head *)((u8 *)event_header +
> +						sizeof(struct tcg_pcr_event) +
> +						event_header->event_size);
> +
> +	while ((void  *)event < sl_evtlog.addr + evtlog20->next_record_offset) {

Ditto.

> +		size = __calc_tpm2_event_size(event, event_header, false);
> +		if (!size)
> +			slaunch_txt_reset(txt,
> +				"TPM20 invalid event in event log\n",
> +				SL_ERROR_TPM_INVALID_EVENT);
> +
> +		/*
> +		 * Marker events indicate where the Secure Launch early stub
> +		 * started and ended adding post launch events.
> +		 */
> +		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
> +			end = 1;
> +			break;
> +		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
> +			start = 1;
> +			goto next;
> +		}
> +
> +		if (start)
> +			slaunch_tpm20_extend_event(tpm, txt, event);
> +
> +next:
> +		event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
> +	}
> +
> +	if (!start || !end)
> +		slaunch_txt_reset(txt,
> +			"Missing start or end events for extending TPM20 PCRs\n",
> +			SL_ERROR_TPM_EXTEND);
> +}

...

> +static void slaunch_pcr_extend(void __iomem *txt)
> +{
> +	struct tpm_chip *tpm;
> +
> +	tpm = tpm_default_chip();
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
> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
> +	    (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT))

nit: spaces around '|'
     Likewise elsewhere in this patch.


> +		return 0;
> +
> +	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
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
> +
> +	return slaunch_expose_securityfs();
> +}

...
