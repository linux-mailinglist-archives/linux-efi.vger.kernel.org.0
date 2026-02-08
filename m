Return-Path: <linux-efi+bounces-6100-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCqhFhmSiGngrQQAu9opvQ
	(envelope-from <linux-efi+bounces-6100-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 08 Feb 2026 14:39:37 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57956108C8F
	for <lists+linux-efi@lfdr.de>; Sun, 08 Feb 2026 14:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59CC23002B7C
	for <lists+linux-efi@lfdr.de>; Sun,  8 Feb 2026 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB69298CBC;
	Sun,  8 Feb 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUJEeUBm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FC4414;
	Sun,  8 Feb 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770557968; cv=none; b=sdNGlYVi7Pueq1tzTI860IInc34OvAbF1QBo8elY0hLBbH/vsoQOcQ52RQdecgg3k0MMQMBmDSXNB3tEeRp1olRRNuPXMjSgQRhX/jb9N63uciZwVx6Kl3J+Bf0EJP3cjWVU/zUw8hSSyzNlCF28raSsYjyj98fPnhEutDXXmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770557968; c=relaxed/simple;
	bh=p5apwxke5Voq6wgYtF+4zURk4Mg2tVFJZzENXvZG7pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG8sEk+MWh2MnkGeoUhkzAgConkMnpGjLdu9BEeNt1tfnOlCIN7bErXQh0yyNLN2NtRUYON/bOU/Rcj1RkDxfS/xfbwkPmEz0WjaYKnye7Do07LmP401o8XteFk/7puF84mBWBph5t9NdFRJ8t9OuO0R9tDRwJsL6ybh7ZTZnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUJEeUBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA29EC4CEF7;
	Sun,  8 Feb 2026 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770557967;
	bh=p5apwxke5Voq6wgYtF+4zURk4Mg2tVFJZzENXvZG7pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUJEeUBm5LsPQs1HT2BaNw9nnF8jBrN1BrdLchoRKC/cBOek3b5rZi3hO43YkXMc1
	 ESyDpK9KraApfctaW2tM5QN6QDKziK2OF5cGKvZkN/vlspHUTe0GUUdT3rL88DxEMQ
	 Wlcu3dQ1Uo8nB1ANrCx5ecm+yTFGopj2MQ3umx48vY/zX1WDVkY46Kq5wIkwrENP/Z
	 mVJJKXEJZ93NuAs1T2gyHX4ZsfRN83pcGjk7rzXCb3ekiNg/669h234k3iLHVHm1F7
	 D80llIqhnKD99pYgMRM4JYqEYjgDEeEyWwJKoFu0CIUFKbV8S2KLsMy02D4D3fFmQZ
	 pDx1SXvFKxfNA==
Date: Sun, 8 Feb 2026 15:39:23 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 02/28] tpm: Move TPM1 specific definitions and
 functions to new headers
Message-ID: <aYiSC5HFWYvSB50d@kernel.org>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-3-ross.philipson@oracle.com>
 <aW7E2dVlmjZIUivW@kernel.org>
 <7aad3461-f0a5-42ff-ba9b-b52edd7d36db@apertussolutions.com>
 <6e1e771c-ecd4-4ab6-ba9f-900f34c5d89d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e1e771c-ecd4-4ab6-ba9f-900f34c5d89d@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6100-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[apertussolutions.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,urldefense.com:url]
X-Rspamd-Queue-Id: 57956108C8F
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:44:34AM -0800, ross.philipson@oracle.com wrote:
> On 2/1/26 8:23 AM, Daniel P. Smith wrote:
> > On 1/19/26 18:57, Jarkko Sakkinen wrote:
> > > On Mon, Dec 15, 2025 at 03:32:50PM -0800, Ross Philipson wrote:
> > > > This gathers all the TPM1 definitions and structures into two separate
> > > > header files (public tpm1.h and private tpm1_structs.h). The definitions
> > > > moved to these files correspond to the TCG specification for TPM 1 family:
> > > > 
> > > > TPM 1.2 Main Specification
> > > >   -  https://urldefense.com/v3/__https://trustedcomputinggroup.org/resource/tpm-main-specification/__;!!ACWV5N9M2RV99hQ!OivTxO-R0nvBJYXIV-T0n0fq0wY64MTgdaecPzAauxrFkRxTcQ6CuBEcXmZZYY1KfZlqmfLTZBbPaEr7Y8k7hJk9_mQ$
> > > > Note that the structures were pulled into tpm1_structs.h to allow their
> > > > external reuse.
> > > > 
> > > > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > > > ---
> > > >   drivers/char/tpm/tpm.h          | 98 +--------------------------------
> > > >   drivers/char/tpm/tpm1-cmd.c     |  5 --
> > > >   drivers/char/tpm/tpm1_structs.h | 97 ++++++++++++++++++++++++++++++++
> > > 
> > > I think you are overcomplicating the patch set and doing more
> > > than you really need to do.
> > > 
> > > I.e. structs could go also just as well to tpm_command.h. We
> > > will deal with if/when that file ever grows too large. It's
> > > absolutely not a priority for this patch set.
> > 
> > Ack.
> > 
> > > >   include/linux/tpm1.h            | 34 +++++++++++-
> > > >   4 files changed, 132 insertions(+), 102 deletions(-)
> > > >   create mode 100644 drivers/char/tpm/tpm1_structs.h
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > > index ca391b2a211c..1f9f8540eede 100644
> > > > --- a/drivers/char/tpm/tpm.h
> > > > +++ b/drivers/char/tpm/tpm.h
> > > > @@ -50,105 +50,9 @@ enum tpm_addr {
> > > >       TPM_ADDR = 0x4E,
> > > >   };
> > > > -#define TPM_WARN_RETRY          0x800
> > > > -#define TPM_WARN_DOING_SELFTEST 0x802
> > > > -#define TPM_ERR_DEACTIVATED     0x6
> > > > -#define TPM_ERR_DISABLED        0x7
> > > > -#define TPM_ERR_FAILEDSELFTEST  0x1C
> > > > -#define TPM_ERR_INVALID_POSTINIT 38
> > > > -
> > > > -#define TPM_TAG_RQU_COMMAND 193
> > > > -
> > > >   /* TPM2 specific constants. */
> > > >   #define TPM2_SPACE_BUFFER_SIZE        16384 /* 16 kB */
> > > > -struct    stclear_flags_t {
> > > > -    __be16    tag;
> > > > -    u8    deactivated;
> > > > -    u8    disableForceClear;
> > > > -    u8    physicalPresence;
> > > > -    u8    physicalPresenceLock;
> > > > -    u8    bGlobalLock;
> > > > -} __packed;
> > > > -
> > > > -struct tpm1_version {
> > > > -    u8 major;
> > > > -    u8 minor;
> > > > -    u8 rev_major;
> > > > -    u8 rev_minor;
> > > > -} __packed;
> > > > -
> > > > -struct tpm1_version2 {
> > > > -    __be16 tag;
> > > > -    struct tpm1_version version;
> > > > -} __packed;
> > > > -
> > > > -struct    timeout_t {
> > > > -    __be32    a;
> > > > -    __be32    b;
> > > > -    __be32    c;
> > > > -    __be32    d;
> > > > -} __packed;
> > > > -
> > > > -struct duration_t {
> > > > -    __be32    tpm_short;
> > > > -    __be32    tpm_medium;
> > > > -    __be32    tpm_long;
> > > > -} __packed;
> > > > -
> > > > -struct permanent_flags_t {
> > > > -    __be16    tag;
> > > > -    u8    disable;
> > > > -    u8    ownership;
> > > > -    u8    deactivated;
> > > > -    u8    readPubek;
> > > > -    u8    disableOwnerClear;
> > > > -    u8    allowMaintenance;
> > > > -    u8    physicalPresenceLifetimeLock;
> > > > -    u8    physicalPresenceHWEnable;
> > > > -    u8    physicalPresenceCMDEnable;
> > > > -    u8    CEKPUsed;
> > > > -    u8    TPMpost;
> > > > -    u8    TPMpostLock;
> > > > -    u8    FIPS;
> > > > -    u8    operator;
> > > > -    u8    enableRevokeEK;
> > > > -    u8    nvLocked;
> > > > -    u8    readSRKPub;
> > > > -    u8    tpmEstablished;
> > > > -    u8    maintenanceDone;
> > > > -    u8    disableFullDALogicInfo;
> > > > -} __packed;
> > > > -
> > > > -typedef union {
> > > > -    struct    permanent_flags_t perm_flags;
> > > > -    struct    stclear_flags_t    stclear_flags;
> > > > -    __u8    owned;
> > > > -    __be32    num_pcrs;
> > > > -    struct tpm1_version version1;
> > > > -    struct tpm1_version2 version2;
> > > > -    __be32    manufacturer_id;
> > > > -    struct timeout_t  timeout;
> > > > -    struct duration_t duration;
> > > > -} cap_t;
> > > > -
> > > > -enum tpm_capabilities {
> > > > -    TPM_CAP_FLAG = 4,
> > > > -    TPM_CAP_PROP = 5,
> > > > -    TPM_CAP_VERSION_1_1 = 0x06,
> > > > -    TPM_CAP_VERSION_1_2 = 0x1A,
> > > > -};
> > > > -
> > > > -enum tpm_sub_capabilities {
> > > > -    TPM_CAP_PROP_PCR = 0x101,
> > > > -    TPM_CAP_PROP_MANUFACTURER = 0x103,
> > > > -    TPM_CAP_FLAG_PERM = 0x108,
> > > > -    TPM_CAP_FLAG_VOL = 0x109,
> > > > -    TPM_CAP_PROP_OWNER = 0x111,
> > > > -    TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
> > > > -    TPM_CAP_PROP_TIS_DURATION = 0x120,
> > > > -};
> > > > -
> > > >   enum tpm2_pt_props {
> > > >       TPM2_PT_NONE = 0x00000000,
> > > >       TPM2_PT_GROUP = 0x00000100,
> > > > @@ -229,6 +133,8 @@ enum tpm2_pt_props {
> > > >    * compiler warnings about stack frame size. */
> > > >   #define TPM_MAX_RNG_DATA    128
> > > > +#include "tpm1_structs.h"
> > > > +
> > > >   extern const struct class tpm_class;
> > > >   extern const struct class tpmrm_class;
> > > >   extern dev_t tpm_devt;
> > > > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > > > index f29827b454d2..02f20a0aa37d 100644
> > > > --- a/drivers/char/tpm/tpm1-cmd.c
> > > > +++ b/drivers/char/tpm/tpm1-cmd.c
> > > > @@ -505,11 +505,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(tpm1_getcap);
> > > > -struct tpm1_get_random_out {
> > > > -    __be32 rng_data_len;
> > > > -    u8 rng_data[TPM_MAX_RNG_DATA];
> > > > -} __packed;
> > > > -
> > > >   /**
> > > >    * tpm1_get_random() - get random bytes from the TPM's RNG
> > > >    * @chip:    a &struct tpm_chip instance
> > > > diff --git a/drivers/char/tpm/tpm1_structs.h b/drivers/char/tpm/tpm1_structs.h
> > > > new file mode 100644
> > > > index 000000000000..ad21376af5ab
> > > > --- /dev/null
> > > > +++ b/drivers/char/tpm/tpm1_structs.h
> > > > @@ -0,0 +1,97 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * Copyright (C) 2004 IBM Corporation
> > > > + * Copyright (C) 2015 Intel Corporation
> > > > + *
> > > > + * Authors:
> > > > + * Leendert van Doorn <leendert@watson.ibm.com>
> > > > + * Dave Safford <safford@watson.ibm.com>
> > > > + * Reiner Sailer <sailer@watson.ibm.com>
> > > > + * Kylene Hall <kjhall@us.ibm.com>
> > > > + *
> > > > + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> > > > + *
> > > > + * Device driver for TCG/TCPA TPM (trusted platform module).
> > > > + * Specifications at https://urldefense.com/v3/__http://www.trustedcomputinggroup.org__;!!ACWV5N9M2RV99hQ!OivTxO-R0nvBJYXIV-T0n0fq0wY64MTgdaecPzAauxrFkRxTcQ6CuBEcXmZZYY1KfZlqmfLTZBbPaEr7Y8k7HW5iz_w$ + */
> > > > +
> > > > +#ifndef __TPM1_STRUCTS_H__
> > > > +#define __TPM1_STRUCTS_H__
> > > > +
> > > > +struct    stclear_flags_t {
> > > > +    __be16    tag;
> > > > +    u8    deactivated;
> > > > +    u8    disableForceClear;
> > > > +    u8    physicalPresence;
> > > > +    u8    physicalPresenceLock;
> > > > +    u8    bGlobalLock;
> > > > +} __packed;
> > > 
> > > 
> > > Don't retain alignment.
> > > 
> > 
> > Okay.
> 
> I wanted to clarify what you are asking here. Do you mean to just not pack the structs? It seems some of these structs define the responses from the TPM chip and I would assume they are packed this way.
> 
> > 
> > > > +
> > > > +struct tpm1_version {
> > > > +    u8 major;
> > > > +    u8 minor;
> > > > +    u8 rev_major;
> > > > +    u8 rev_minor;
> > > > +} __packed;
> > > > +
> > > > +struct tpm1_version2 {
> > > > +    __be16 tag;
> > > > +    struct tpm1_version version;
> > > > +} __packed;
> > > > +
> > > > +struct    timeout_t {
> > > > +    __be32    a;
> > > > +    __be32    b;
> > > > +    __be32    c;
> > > > +    __be32    d;
> > > > +} __packed;
> > > > +
> > > > +struct duration_t {
> > > > +    __be32    tpm_short;
> > > > +    __be32    tpm_medium;
> > > > +    __be32    tpm_long;
> > > > +} __packed;
> > > > +
> > > > +struct permanent_flags_t {
> > > > +    __be16    tag;
> > > > +    u8    disable;
> > > > +    u8    ownership;
> > > > +    u8    deactivated;
> > > > +    u8    readPubek;
> > > > +    u8    disableOwnerClear;
> > > > +    u8    allowMaintenance;
> > > > +    u8    physicalPresenceLifetimeLock;
> > > > +    u8    physicalPresenceHWEnable;
> > > > +    u8    physicalPresenceCMDEnable;
> > > > +    u8    CEKPUsed;
> > > > +    u8    TPMpost;
> > > > +    u8    TPMpostLock;
> > > > +    u8    FIPS;
> > > > +    u8    operator;
> > > > +    u8    enableRevokeEK;
> > > > +    u8    nvLocked;
> > > > +    u8    readSRKPub;
> > > > +    u8    tpmEstablished;
> > > > +    u8    maintenanceDone;
> > > > +    u8    disableFullDALogicInfo;
> > > > +} __packed;
> > > > +
> > > > +/* Gather all capabilities related information info one type */
> > > > +typedef union {
> > > > +    struct    permanent_flags_t perm_flags;
> > > > +    struct    stclear_flags_t    stclear_flags;
> > > > +    __u8    owned;
> > > > +    __be32    num_pcrs;
> > > > +    struct tpm1_version version1;
> > > > +    struct tpm1_version2 version2;
> > > > +    __be32    manufacturer_id;
> > > > +    struct timeout_t  timeout;
> > > > +    struct duration_t duration;
> > > > +} cap_t;
> > > 
> > > Don't retain alignment here.
> 
> Again to clarify, do you mean none of these structs should be packed (and thus the union won't be either)?

I only meant the syntactical (is that even a word) alignment :-)

I don't know what purpose does it serve here, as struct members already
convolute, and alignment then sort of add up to the convolution.

E.g., "__be32 manufacturer_id" with just one spacebar is what I mean.

> 
> Thanks
> Ross
> 
> > > 
> > 
> > Okay.
> > 
> > > > +
> > > > +struct tpm1_get_random_out {
> > > > +    __be32 rng_data_len;
> > > > +    u8 rng_data[TPM_MAX_RNG_DATA];
> > > > +} __packed;
> > > > +
> > > > +#endif
> > > > diff --git a/include/linux/tpm1.h b/include/linux/tpm1.h
> > > > index 54c6c211eb9e..5fad94ac8d15 100644
> > > > --- a/include/linux/tpm1.h
> > > > +++ b/include/linux/tpm1.h
> > > > @@ -47,7 +47,39 @@ enum tpm_command_ordinals {
> > > >       TPM_ORD_UNSEAL            = 24,
> > > >   };
> > > > -/* Other constants */
> > > > +enum tpm_capabilities {
> > > > +    TPM_CAP_FLAG        = 4,
> > > > +    TPM_CAP_PROP        = 5,
> > > > +    TPM_CAP_VERSION_1_1    = 0x06,
> > > > +    TPM_CAP_VERSION_1_2    = 0x1A,
> > > > +};
> > > > +
> > > > +enum tpm_sub_capabilities {
> > > > +    TPM_CAP_PROP_PCR        = 0x101,
> > > > +    TPM_CAP_PROP_MANUFACTURER    = 0x103,
> > > > +    TPM_CAP_FLAG_PERM        = 0x108,
> > > > +    TPM_CAP_FLAG_VOL        = 0x109,
> > > > +    TPM_CAP_PROP_OWNER        = 0x111,
> > > > +    TPM_CAP_PROP_TIS_TIMEOUT    = 0x115,
> > > > +    TPM_CAP_PROP_TIS_DURATION    = 0x120,
> > > > +};
> > > > +
> > > > +/* Return Codes */
> > > > +enum tpm_return_codes {
> > > > +    TPM_BASE_MASK            = 0,
> > > > +    TPM_NON_FATAL_MASK        = 0x00000800,
> > > > +    TPM_SUCCESS            = TPM_BASE_MASK + 0,
> > > > +    TPM_ERR_DEACTIVATED        = TPM_BASE_MASK + 6,
> > > > +    TPM_ERR_DISABLED        = TPM_BASE_MASK + 7,
> > > > +    TPM_ERR_FAIL            = TPM_BASE_MASK + 9,
> > > > +    TPM_ERR_FAILEDSELFTEST        = TPM_BASE_MASK + 28,
> > > > +    TPM_ERR_INVALID_POSTINIT    = TPM_BASE_MASK + 38,
> > > > +    TPM_ERR_INVALID_FAMILY        = TPM_BASE_MASK + 55,
> > > > +    TPM_WARN_RETRY            = TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
> > > > +    TPM_WARN_DOING_SELFTEST        = TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
> > > > +};
> > > > +
> > > > +/* Misc. constants */
> > > 
> > > These constants should be relocated in a separate patch.
> > > 
> > 
> > Okay.
> > 
> > > >   #define SRKHANDLE                       0x40000000
> > > >   #define TPM_NONCE_SIZE                  20
> > > >   #define TPM_ST_CLEAR            1
> > > > -- 
> > > > 2.43.7
> > > > 
> > > 
> > > BR, Jarkko
> > 
> 

BR, Jarkko

