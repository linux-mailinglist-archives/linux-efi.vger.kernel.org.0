Return-Path: <linux-efi+bounces-6079-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MNFN65bgGlj7AIAu9opvQ
	(envelope-from <linux-efi+bounces-6079-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 02 Feb 2026 09:09:18 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AE9C981B
	for <lists+linux-efi@lfdr.de>; Mon, 02 Feb 2026 09:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B970D30382A1
	for <lists+linux-efi@lfdr.de>; Mon,  2 Feb 2026 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CAE22DFA4;
	Mon,  2 Feb 2026 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbRIq891"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A130F7EA
	for <linux-efi@vger.kernel.org>; Mon,  2 Feb 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019278; cv=none; b=QfmwgOOzSNSoOeJ28itg/09LzZ1W3sCkDgRQ6DnB7SAnCTc34JuPx7/KoT8acMHDHTMjuWV2W8mQU93/wdGVS7G6MRHcGx3W07+EXfMdnR1OiBcm1fBX3FgNQiaZT5dYDgjFpndhQeKJXFogxHufJ7qTKJMC/983hPg7KqxZ74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019278; c=relaxed/simple;
	bh=Gpa7TO42qLDaaK7rvjxkwHnmN2Z6us+3ErmDg7wFIC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUo0H5+pyEX4hRXwYPL0w82aFuoP6yGP1feOYq/R9l4dUtkNZ9w/IS+jYDjbpe/cNL4jU4M8nQ+8ZaPJCG5dMAnpduiVFvf8KJdJfAEGN5o9maHH6efhHlPuOCjYG74EbrYVAIVDH3POS3FXfp80Nb333yLNyjHeDXVet0U5vKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbRIq891; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c61343f82d7so1634982a12.1
        for <linux-efi@vger.kernel.org>; Mon, 02 Feb 2026 00:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770019277; x=1770624077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gpa7TO42qLDaaK7rvjxkwHnmN2Z6us+3ErmDg7wFIC0=;
        b=dbRIq891s0VTHtOeNPz+RLBOMq5ri44qi601F+wjTeoiXcq5KEnBpFYx//3YtY/TA9
         eGVzdVi/KNv6dZPKh56O/8vJ6E9aQslzofwXNzbkjoPjwYP5CdH6alOfT/XxElW90ug1
         1B+6c78BDgF7som23wiudH6wBk738iX0XXxCh9BzqbwFF8LLzo69P33OxginX52XF0s6
         2kxQwFjiYW3Te4fD834+Y86ptSdig3jJlnWFPO1eHy0LyJfAsbvBXW1knjw9xYScAVUV
         ZyIATd4P4mZet8UEp8L5pmmaysMSL5XTh4PNgmWhAVmwfVTzFbFqeEimB1Tg1jKXfnH0
         uNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770019277; x=1770624077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gpa7TO42qLDaaK7rvjxkwHnmN2Z6us+3ErmDg7wFIC0=;
        b=lGmG9pg2FDTt7H4/ANgCWHC8m7oeUWsnLS+ZiTkjyewB8nlRY9YqIYb05VQdTiePtR
         JpxOyLgbl3dmHAMBMlv6RcGw639PJlJ0G3gTEagvAepXyJSUfjXMfuINupNPJnKGYUvh
         1Km0tPPlg6ZYDmmkUDntA4RL+7gI469CCWaGqbKCkbbvpsXwaOpoQQiSe6Cx00ytRbYY
         Jp7BZP0cojJZLHo+W5KdgdP8aA53+Bgnt0J46xfp5dF0ASSTYA/w53CYxyfAlEuLvHp7
         SNYRkX+3oq8+LhV4sRvhh6c6K61I87Jktn1CdAGzz610/KQYvvsPexriOSPhkAaAYQzk
         Gg9g==
X-Forwarded-Encrypted: i=1; AJvYcCUoZr6iyHHicrdjvXJ2zoBwU+4U11Es/NetAs90OsLd5ZSK6sXgw2ndm2sKWeDJrbf1WoZ45WC1XxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGTicJwUCRwqPUeWEgc1m7L+CxRVWqRsn1dIpNL72KYcbFlCy
	YnebHqTrJBW7jRML6PLwNq+qZiqHGCAg/6wPk2rk1dYPwgGeY0+Xdew=
X-Gm-Gg: AZuq6aKUl/HeLYdA1pjJ5Aow3ED5R6C7JNLlaKGbh2Wql2feja9j2Tp2fBelxZk2lbx
	tLNXD1+e2cLVG/2sNxmIiX5K3mb1gCUSlxwKIvIEWevlC7UFVjlwJv4Mo2KaxR017tDIFhXKQH6
	oF73f1scxy+/+TkUZTxWoElHmpD2+lGTo07srqClPu3e/l8SxYJdinsnf9h2nIDBLMgM/BrGuUX
	tht026KbcmfkFAFNTy82eFLDrmsUTxlKSos39n2aeRaoWSgCBge945YD3r0P3kQ26tFVLl3sz7a
	gTa9i+EB9n5JSPNMDeLvqPeBRAuQx2QftAaYwTqBd/WW142LBCPOb9odA97f3o9akAwZJxUziC5
	5JHIYXH4/aT/nL861TNOyjkQazunHkrFCWjY58TjFwvKEEapl7cbSXn2DOuHjxFROeNfWbALYjy
	OLh/aVIzAlkZZF7BE=
X-Received: by 2002:a17:90b:3dcb:b0:340:b912:536 with SMTP id 98e67ed59e1d1-3543b3ad361mr9815251a91.31.1770019275904;
        Mon, 02 Feb 2026 00:01:15 -0800 (PST)
Received: from at.. ([171.61.160.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f02aasm14655168a91.7.2026.02.02.00.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 00:01:15 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: lukas@wunner.de
Cc: airlied@gmail.com,
	ardb@kernel.org,
	atharvatiwarilinuxdev@gmail.com,
	bp@alien8.de,
	dri-devel@lists.freedesktop.org,
	francescopompo2@gmail.com,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	javierm@redhat.com,
	joonas.lahtinen@linux.intel.com,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lszubowi@redhat.com,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	tzimmermann@suse.de
Subject: Re: [PATCH v2 1/2] efi/libstub: enable apple-set-os for all apple devices
Date: Mon,  2 Feb 2026 08:01:06 +0000
Message-ID: <20260202080106.1093-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aXovFQsk-w90wZi1@wunner.de>
References: <aXovFQsk-w90wZi1@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6079-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,alien8.de,lists.freedesktop.org,linux.intel.com,redhat.com,vger.kernel.org,intel.com,ffwll.ch,ursulin.net,suse.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-efi];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38AE9C981B
X-Rspamd-Action: no action

> Maybe you could give it a spin and verify if it fixes the issue for you?

I tested it, and only tested to see if it booted.
now again i tested, and it seems my iGPU and eGPU wasnt detected?
and after futher debuging i found that setup_efi_pci only detected
dGPU, so using update_nr_gpus was useless.

and about the macbookair situation, i say we just exclude macbook from
enabling apple-set-os via a smbios quirk.

