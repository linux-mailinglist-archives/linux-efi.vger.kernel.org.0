Return-Path: <linux-efi+bounces-186-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409F880E092
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 01:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73762825F8
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31F7E3;
	Tue, 12 Dec 2023 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="CyC8hYrE"
X-Original-To: linux-efi@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BFEB5;
	Mon, 11 Dec 2023 16:58:09 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6CB2D4C2DF8;
	Tue, 12 Dec 2023 00:58:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0AD7C4C2C22;
	Tue, 12 Dec 2023 00:58:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702342689; a=rsa-sha256;
	cv=none;
	b=eTXXI+d9184680CmhnqF5+JuLdebYACzZuFEKACXTEE3mQuo+bc8AOm1UcEObkTL26YRx4
	3ES9DXQd2q19zC5Ea/1GznMJPN5qwbNGvTWAgue6GP23VoBNda4Ub44IcYHts2xVbOnaDq
	UHdEC1e99TEqxsFhJ3O5cY3Pd29z3WmksIb0a7wuiIh5Y6iiSZQqgexLEHYmNQhRl2TB6O
	O0P8M8NimsFBIyskBXnsUYXd6B3ydTShl+Pp7ZysvMv1Cn2Tziw1asTVu7t5/63BnlEW9I
	/YNE/AJ0mVwmthqVpGs6rgJmk+UnZqtuBQRUvXKNQDAJOoOyBJ8pasTxdpuooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702342689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CgfKRMheSkqnl8ntcQN0nmMh5qA42129g0uV+BIM/OI=;
	b=YUBKV4BYUAfic5ddG347UMFPmZiWaQs4q9B8xxYVvkq6KOamobCO8sZBqy+5P/ckIZObvh
	nWA0xmWSFRKMad4VmSTa9AS/FN0f2LcuratlRxDjpyRKyFsw6oCES6Htd4c6a3+7EjoAVJ
	9OVCkNUb7jaAqAoi6HWyNGVTPi5xY+YUsTfOo43aWzKkJs9dgr0P4SyeSrSeP0cM1jAID6
	yb93YNSjzyb+bZBxzIH6gbLSV3sj8RIKY1dvNBlMD5iz1EJPMr6uf50FqgRTfThws4i511
	zFTYLqv9Whb3dYN+3j07hv2fTpdWESfdrpanLQYT6OWiPQKlVMcwol442Ig2Hw==
ARC-Authentication-Results: i=1;
	rspamd-5749745b69-wvdkh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Share: 6f2289257be685eb_1702342689325_3723607419
X-MC-Loop-Signature: 1702342689325:4121069608
X-MC-Ingress-Time: 1702342689325
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.88.203 (trex/6.9.2);
	Tue, 12 Dec 2023 00:58:09 +0000
Received: from offworld (unknown [172.56.169.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4Sq0bM4C2Bz2Z;
	Mon, 11 Dec 2023 16:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1702342688;
	bh=jX4TX+3XoGz0TKeEzPzBF4bJLhyIn3MnVarrjC/g2HU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=CyC8hYrEbYouGvlPmpsh5MEDxAdqxPg67IWIJSXZzg9yfupdCVPecJ4SsiBhqdinn
	 B39EknE9cIrj3JsPaM04Wv1dMe6NbBDNGnVrEQJyQCnRCkzggCv1XRb96i1e8adYCy
	 ETAa7fgRI2IU9x8LL6T+2c0ogfdtqLrgmnZc5E/8HniNqSEGYYG4Qt0M3JROhfe04C
	 1+vVCTD3Ep3njjBxSBKnXFdUvfSQqQuqqsNCUTJhQliNL5E0tpjUn8xXqd3+1ViU5R
	 sK1ULP9fu8KyBzv5qDHWqd68xr7fDCFHrzseYwaxoYDy9JidBMdEDuGPjIsc+2Tc99
	 xCFXtr2t1ZM4Q==
Date: Mon, 11 Dec 2023 16:57:57 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ard Biesheuvel <ardb@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] block: partitions: efi: Fix some style issues
Message-ID: <6lhqirdaqmaqk6bpyywmnsj5oon2nvcq2wn6napir5df4md6q3@mu6w5ql45tf7>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
 <20231211151244.289349-3-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231211151244.289349-3-romain.gantois@bootlin.com>
User-Agent: NeoMutt/20231103

On Mon, 11 Dec 2023, Romain Gantois wrote:

>The block layer EFI code is quite old and does not perfectly match the
>current kernel coding style. Fix some indentation and trailing whitespace
>issues in efi.c.

I agree that the styling can use some love. However, a few comments below
where such changes are really unnecessary.

...

>@@ -213,7 +212,7 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
>	 */
>	if (ret == GPT_MBR_PROTECTIVE) {
>		sz = le32_to_cpu(mbr->partition_record[part].size_in_lba);
>-		if (sz != (uint32_t) total_sectors - 1 && sz != 0xFFFFFFFF)
>+		if (sz != (uint32_t)total_sectors - 1 && sz != 0xFFFFFFFF)

Like here.

>			pr_debug("GPT: mbr size in lba (%u) different than whole disk (%u).\n",
>				 sz, min_t(uint32_t,
>					   total_sectors - 1, 0xFFFFFFFF));
>@@ -235,17 +234,19 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
> static size_t read_lba(struct parsed_partitions *state,
>		       u64 lba, u8 *buffer, size_t count)
> {
>-	size_t totalreadcount = 0;
>	sector_t n = lba *
>		(queue_logical_block_size(state->disk->queue) / 512);
>+	size_t totalreadcount = 0;
>+	unsigned char *data;
>+	Sector sect;
>+	int copied;
>
>	if (!buffer || lba > last_lba(state->disk))
>-                return 0;
>+		return 0;
>
>	while (count) {
>-		int copied = 512;
>-		Sector sect;
>-		unsigned char *data = read_part_sector(state, n++, &sect);
>+		copied = 512;
>+		data = read_part_sector(state, n++, &sect);

ditto

>		if (!data)
>			break;
>		if (copied > count)
>@@ -253,7 +254,7 @@ static size_t read_lba(struct parsed_partitions *state,
>		memcpy(buffer, data, copied);
>		put_dev_sector(sect);
>		buffer += copied;
>-		totalreadcount +=copied;
>+		totalreadcount += copied;
>		count -= copied;
>	}
>	return totalreadcount;
>@@ -263,7 +264,7 @@ static size_t read_lba(struct parsed_partitions *state,
>  * alloc_read_gpt_entries(): reads partition entries from disk
>  * @state: disk parsed partitions
>  * @gpt: GPT header
>- *
>+ *
>  * Description: Returns ptes on success,  NULL on error.
>  * Allocates space for PTEs based on information found in @gpt.
>  * Notes: remember to free pte when you're done!
>@@ -271,14 +272,14 @@ static size_t read_lba(struct parsed_partitions *state,
> static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
>					 gpt_header *gpt)
> {
>-	size_t count;
>	gpt_entry *pte;
>+	size_t count;

ditto

>
>	if (!gpt)
>		return NULL;
>
>	count = (size_t)le32_to_cpu(gpt->num_partition_entries) *
>-                le32_to_cpu(gpt->sizeof_partition_entry);
>+		le32_to_cpu(gpt->sizeof_partition_entry);
>	if (!count)
>		return NULL;
>	pte = kmalloc(count, GFP_KERNEL);
>@@ -286,9 +287,9 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
>		return NULL;
>
>	if (read_lba(state, le64_to_cpu(gpt->partition_entry_lba),
>-			(u8 *) pte, count) < count) {
>+		     (u8 *)pte, count) < count) {
>		kfree(pte);
>-                pte=NULL;
>+		pte = NULL;
>		return NULL;
>	}
>	return pte;
>@@ -298,7 +299,7 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
>  * alloc_read_gpt_header(): Allocates GPT header, reads into it from disk
>  * @state: disk parsed partitions
>  * @lba: the Logical Block Address of the partition table
>- *
>+ *
>  * Description: returns GPT header on success, NULL on error.   Allocates
>  * and fills a GPT header starting at @ from @state->disk.
>  * Note: remember to free gpt when finished with it.
>@@ -306,16 +307,16 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
> static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
>					 u64 lba)
> {
>+	unsigned int ssz = queue_logical_block_size(state->disk->queue);
>	gpt_header *gpt;
>-	unsigned ssz = queue_logical_block_size(state->disk->queue);

ditto

>
>	gpt = kmalloc(ssz, GFP_KERNEL);
>	if (!gpt)
>		return NULL;
>
>-	if (read_lba(state, lba, (u8 *) gpt, ssz) < ssz) {
>+	if (read_lba(state, lba, (u8 *)gpt, ssz) < ssz) {

ditto

>		kfree(gpt);
>-                gpt=NULL;
>+		gpt = NULL;
>		return NULL;
>	}
>
>@@ -486,31 +487,31 @@ compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
>	if (le64_to_cpu(pgpt->my_lba) != le64_to_cpu(agpt->alternate_lba)) {
>		pr_warn("GPT:Primary header LBA != Alt. header alternate_lba\n");
>		pr_warn("GPT:%lld != %lld\n",
>-		       (unsigned long long)le64_to_cpu(pgpt->my_lba),
>-                       (unsigned long long)le64_to_cpu(agpt->alternate_lba));
>+			(unsigned long long)le64_to_cpu(pgpt->my_lba),
>+			(unsigned long long)le64_to_cpu(agpt->alternate_lba));
>		error_found++;
>	}
>	if (le64_to_cpu(pgpt->alternate_lba) != le64_to_cpu(agpt->my_lba)) {
>		pr_warn("GPT:Primary header alternate_lba != Alt. header my_lba\n");
>		pr_warn("GPT:%lld != %lld\n",
>-		       (unsigned long long)le64_to_cpu(pgpt->alternate_lba),
>-                       (unsigned long long)le64_to_cpu(agpt->my_lba));
>+			(unsigned long long)le64_to_cpu(pgpt->alternate_lba),
>+			(unsigned long long)le64_to_cpu(agpt->my_lba));
>		error_found++;
>	}
>	if (le64_to_cpu(pgpt->first_usable_lba) !=
>-            le64_to_cpu(agpt->first_usable_lba)) {
>+	    le64_to_cpu(agpt->first_usable_lba)) {
>		pr_warn("GPT:first_usable_lbas don't match.\n");
>		pr_warn("GPT:%lld != %lld\n",
>-		       (unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
>-                       (unsigned long long)le64_to_cpu(agpt->first_usable_lba));
>+			(unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
>+			(unsigned long long)le64_to_cpu(agpt->first_usable_lba));
>		error_found++;
>	}
>	if (le64_to_cpu(pgpt->last_usable_lba) !=
>-            le64_to_cpu(agpt->last_usable_lba)) {
>+	    le64_to_cpu(agpt->last_usable_lba)) {
>		pr_warn("GPT:last_usable_lbas don't match.\n");
>		pr_warn("GPT:%lld != %lld\n",
>-		       (unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
>-                       (unsigned long long)le64_to_cpu(agpt->last_usable_lba));
>+			(unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
>+			(unsigned long long)le64_to_cpu(agpt->last_usable_lba));
>		error_found++;
>	}
>	if (efi_guidcmp(pgpt->disk_guid, agpt->disk_guid)) {
>@@ -518,27 +519,24 @@ compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
>		error_found++;
>	}
>	if (le32_to_cpu(pgpt->num_partition_entries) !=
>-            le32_to_cpu(agpt->num_partition_entries)) {
>-		pr_warn("GPT:num_partition_entries don't match: "
>-		       "0x%x != 0x%x\n",
>-		       le32_to_cpu(pgpt->num_partition_entries),
>-		       le32_to_cpu(agpt->num_partition_entries));
>+	    le32_to_cpu(agpt->num_partition_entries)) {
>+		pr_warn("GPT:num_partition_entries don't match: 0x%x != 0x%x\n",
>+			le32_to_cpu(pgpt->num_partition_entries),
>+			le32_to_cpu(agpt->num_partition_entries));
>		error_found++;
>	}
>	if (le32_to_cpu(pgpt->sizeof_partition_entry) !=
>-            le32_to_cpu(agpt->sizeof_partition_entry)) {
>-		pr_warn("GPT:sizeof_partition_entry values don't match: "
>-		       "0x%x != 0x%x\n",
>-                       le32_to_cpu(pgpt->sizeof_partition_entry),
>-		       le32_to_cpu(agpt->sizeof_partition_entry));
>+	    le32_to_cpu(agpt->sizeof_partition_entry)) {
>+		pr_warn("GPT:sizeof_partition_entry values don't match: 0x%x != 0x%x\n",
>+			le32_to_cpu(pgpt->sizeof_partition_entry),
>+			le32_to_cpu(agpt->sizeof_partition_entry));
>		error_found++;
>	}
>	if (le32_to_cpu(pgpt->partition_entry_array_crc32) !=
>-            le32_to_cpu(agpt->partition_entry_array_crc32)) {
>-		pr_warn("GPT:partition_entry_array_crc32 values don't match: "
>-		       "0x%x != 0x%x\n",
>-                       le32_to_cpu(pgpt->partition_entry_array_crc32),
>-		       le32_to_cpu(agpt->partition_entry_array_crc32));
>+	    le32_to_cpu(agpt->partition_entry_array_crc32)) {
>+		pr_warn("GPT:partition_entry_array_crc32 values don't match: 0x%x != 0x%x\n",
>+			le32_to_cpu(pgpt->partition_entry_array_crc32),
>+			le32_to_cpu(agpt->partition_entry_array_crc32));
>		error_found++;
>	}
>	if (le64_to_cpu(pgpt->alternate_lba) != lastlba) {
>@@ -581,20 +579,22 @@ compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
> static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>			  gpt_entry **ptes)
> {
>+	sector_t total_sectors = get_capacity(state->disk);
>	int good_pgpt = 0, good_agpt = 0, good_pmbr = 0;
>-	gpt_header *pgpt = NULL, *agpt = NULL;
>+	const struct block_device_operations *fops;
>	gpt_entry *pptes = NULL, *aptes = NULL;
>-	legacy_mbr *legacymbr;
>+	gpt_header *pgpt = NULL, *agpt = NULL;
>	struct gendisk *disk = state->disk;
>-	const struct block_device_operations *fops = disk->fops;
>-	sector_t total_sectors = get_capacity(state->disk);
>+	legacy_mbr *legacymbr;
>	u64 lastlba;
>
>+	fops = disk->fops;

ditto

>+
>	if (!ptes)
>		return 0;
>
>	lastlba = last_lba(state->disk);
>-        if (!force_gpt) {
>+	if (!force_gpt) {
>		/* This will be added to the EFI Spec. per Intel after v1.02. */
>		legacymbr = kzalloc(sizeof(*legacymbr), GFP_KERNEL);
>		if (!legacymbr)
>@@ -609,17 +609,17 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>
>		pr_debug("Device has a %s MBR\n",
>			 good_pmbr == GPT_MBR_PROTECTIVE ?
>-						"protective" : "hybrid");
>+			 "protective" : "hybrid");
>	}
>
>	good_pgpt = is_gpt_valid(state, GPT_PRIMARY_PARTITION_TABLE_LBA,
>				 &pgpt, &pptes);
>-        if (good_pgpt)
>+	if (good_pgpt)
>		good_agpt = is_gpt_valid(state,
>					 le64_to_cpu(pgpt->alternate_lba),
>					 &agpt, &aptes);
>-        if (!good_agpt && force_gpt)
>-                good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>+	if (!good_agpt && force_gpt)
>+		good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>
>	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
>		sector_t agpt_sector;
>@@ -631,39 +631,38 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>						 &agpt, &aptes);
>	}
>
>-        /* The obviously unsuccessful case */
>-        if (!good_pgpt && !good_agpt)
>-                goto fail;
>+	/* The obviously unsuccessful case */
>+	if (!good_pgpt && !good_agpt)
>+		goto fail;
>
>         compare_gpts(pgpt, agpt, lastlba);
>
>-        /* The good cases */
>-        if (good_pgpt) {
>-                *gpt  = pgpt;
>-                *ptes = pptes;
>-                kfree(agpt);
>-                kfree(aptes);
>+	/* The good cases */
>+	if (good_pgpt) {
>+		*gpt  = pgpt;
>+		*ptes = pptes;
>+		kfree(agpt);
>+		kfree(aptes);
>		if (!good_agpt)
>-                        pr_warn("Alternate GPT is invalid, using primary GPT.\n");
>-                return 1;
>-        }
>-        else if (good_agpt) {
>-                *gpt  = agpt;
>-                *ptes = aptes;
>-                kfree(pgpt);
>-                kfree(pptes);
>+			pr_warn("Alternate GPT is invalid, using primary GPT.\n");
>+		return 1;
>+	} else if (good_agpt) {
>+		*gpt  = agpt;
>+		*ptes = aptes;
>+		kfree(pgpt);
>+		kfree(pptes);
>		pr_warn("Primary GPT is invalid, using alternate GPT.\n");
>-                return 1;
>-        }
>+		return 1;
>+	}
>
>- fail:
>-        kfree(pgpt);
>-        kfree(agpt);
>-        kfree(pptes);
>-        kfree(aptes);
>-        *gpt = NULL;
>-        *ptes = NULL;
>-        return 0;
>+fail:
>+	kfree(pgpt);
>+	kfree(agpt);
>+	kfree(pptes);
>+	kfree(aptes);
>+	*gpt = NULL;
>+	*ptes = NULL;
>+	return 0;
> }
>
> /**
>@@ -712,10 +711,10 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
>  */
> int efi_partition(struct parsed_partitions *state)
> {
>+	unsigned int ssz = queue_logical_block_size(state->disk->queue) / 512;
>	gpt_header *gpt = NULL;
>	gpt_entry *ptes = NULL;
>	u32 i;
>-	unsigned ssz = queue_logical_block_size(state->disk->queue) / 512;

ditto

>
>	if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
>		kfree(gpt);
>@@ -725,17 +724,17 @@ int efi_partition(struct parsed_partitions *state)
>
>	pr_debug("GUID Partition Table is valid!  Yea!\n");
>
>-	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
>+	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit - 1; i++) {

ditto

>		struct partition_meta_info *info;
>-		unsigned label_max;
>+		unsigned int label_max;
>		u64 start = le64_to_cpu(ptes[i].starting_lba);
>		u64 size = le64_to_cpu(ptes[i].ending_lba) -
>-			   le64_to_cpu(ptes[i].starting_lba) + 1ULL;
>+			le64_to_cpu(ptes[i].starting_lba) + 1ULL;
>
>		if (!is_pte_valid(&ptes[i], last_lba(state->disk)))
>			continue;
>
>-		put_partition(state, i+1, start * ssz, size * ssz);
>+		put_partition(state, i + 1, start * ssz, size * ssz);
>
>		/* If this is a RAID volume, tell md */
>		if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
>diff --git a/include/linux/gpt.h b/include/linux/gpt.h
>index 84b9f36b9e47..633be6bc826c 100644
>--- a/include/linux/gpt.h
>+++ b/include/linux/gpt.h
>@@ -4,7 +4,7 @@
>  * Per Intel EFI Specification v1.02
>  * http://developer.intel.com/technology/efi/efi.htm
>  *
>- * By Matt Domsch <Matt_Domsch@dell.com>  Fri Sep 22 22:15:56 CDT 2000
>+ * By Matt Domsch <Matt_Domsch@dell.com>  Fri Sep 22 22:15:56 CDT 2000
>  *   Copyright 2000,2001 Dell Inc.
>  ************************************************************/
>
>@@ -31,26 +31,26 @@
> #define GPT_PRIMARY_PARTITION_TABLE_LBA 1
>
> #define PARTITION_SYSTEM_GUID \
>-    EFI_GUID( 0xC12A7328, 0xF81F, 0x11d2, \
>-              0xBA, 0x4B, 0x00, 0xA0, 0xC9, 0x3E, 0xC9, 0x3B)
>+	EFI_GUID(0xC12A7328, 0xF81F, 0x11d2, \
>+		 0xBA, 0x4B, 0x00, 0xA0, 0xC9, 0x3E, 0xC9, 0x3B)
> #define LEGACY_MBR_PARTITION_GUID \
>-    EFI_GUID( 0x024DEE41, 0x33E7, 0x11d3, \
>-              0x9D, 0x69, 0x00, 0x08, 0xC7, 0x81, 0xF3, 0x9F)
>+	EFI_GUID(0x024DEE41, 0x33E7, 0x11d3, \
>+		 0x9D, 0x69, 0x00, 0x08, 0xC7, 0x81, 0xF3, 0x9F)
> #define PARTITION_MSFT_RESERVED_GUID \
>-    EFI_GUID( 0xE3C9E316, 0x0B5C, 0x4DB8, \
>-              0x81, 0x7D, 0xF9, 0x2D, 0xF0, 0x02, 0x15, 0xAE)
>+	EFI_GUID(0xE3C9E316, 0x0B5C, 0x4DB8, \
>+		 0x81, 0x7D, 0xF9, 0x2D, 0xF0, 0x02, 0x15, 0xAE)
> #define PARTITION_BASIC_DATA_GUID \
>-    EFI_GUID( 0xEBD0A0A2, 0xB9E5, 0x4433, \
>-              0x87, 0xC0, 0x68, 0xB6, 0xB7, 0x26, 0x99, 0xC7)
>+	EFI_GUID(0xEBD0A0A2, 0xB9E5, 0x4433, \
>+		 0x87, 0xC0, 0x68, 0xB6, 0xB7, 0x26, 0x99, 0xC7)
> #define PARTITION_LINUX_RAID_GUID \
>-    EFI_GUID( 0xa19d880f, 0x05fc, 0x4d3b, \
>-              0xa0, 0x06, 0x74, 0x3f, 0x0f, 0x84, 0x91, 0x1e)
>+	EFI_GUID(0xa19d880f, 0x05fc, 0x4d3b, \
>+		 0xa0, 0x06, 0x74, 0x3f, 0x0f, 0x84, 0x91, 0x1e)
> #define PARTITION_LINUX_SWAP_GUID \
>-    EFI_GUID( 0x0657fd6d, 0xa4ab, 0x43c4, \
>-              0x84, 0xe5, 0x09, 0x33, 0xc8, 0x4b, 0x4f, 0x4f)
>+	EFI_GUID(0x0657fd6d, 0xa4ab, 0x43c4, \
>+		 0x84, 0xe5, 0x09, 0x33, 0xc8, 0x4b, 0x4f, 0x4f)
> #define PARTITION_LINUX_LVM_GUID \
>-    EFI_GUID( 0xe6d6d379, 0xf507, 0x44c2, \
>-              0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28)
>+	EFI_GUID(0xe6d6d379, 0xf507, 0x44c2, \
>+		 0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28)
>
> typedef struct _gpt_header {
>	__le64 signature;
>@@ -78,7 +78,7 @@ typedef struct _gpt_header {
> typedef struct _gpt_entry_attributes {
>	u64 required_to_function:1;
>	u64 reserved:47;
>-        u64 type_guid_specific:16;
>+	u64 type_guid_specific:16;
> } __packed gpt_entry_attributes;
>
> typedef struct _gpt_entry {
>@@ -87,7 +87,7 @@ typedef struct _gpt_entry {
>	__le64 starting_lba;
>	__le64 ending_lba;
>	gpt_entry_attributes attributes;
>-	__le16 partition_name[72/sizeof(__le16)];
>+	__le16 partition_name[72 / sizeof(__le16)];
> } __packed gpt_entry;
>
> typedef struct _gpt_mbr_record {
>@@ -103,7 +103,6 @@ typedef struct _gpt_mbr_record {
>	__le32	size_in_lba;    /* used by EFI - size of pt in LBA */
> } __packed gpt_mbr_record;
>
>-
> typedef struct _legacy_mbr {
>	u8 boot_code[440];
>	__le32 unique_mbr_signature;
>--
>2.43.0
>

