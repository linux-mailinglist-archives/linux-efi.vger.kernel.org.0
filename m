Return-Path: <linux-efi+bounces-6055-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDBWMcSee2nOGAIAu9opvQ
	(envelope-from <linux-efi+bounces-6055-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 18:54:12 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DCDB3462
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24B773017509
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7193559E1;
	Thu, 29 Jan 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EehsUVX3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC44347BA5
	for <linux-efi@vger.kernel.org>; Thu, 29 Jan 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709249; cv=none; b=TbZXxk5yaOBrWR6J9ntoovO8aWRNhRD+Ldi3bVjnnmumZAmwCSHmiVZsjhU6lotj8n2GGdWkl9HpRlDT5DdWCB+dN6q7C3N+jyisvDlG7u2skcLPNQkJZdUyfGehvs/psBXrHKfu+KbVvzwwz20fAF+poD/IovebLUJauLfHKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709249; c=relaxed/simple;
	bh=qzfHTW2cm4zqFY3iV943aAJAFHi3n14dNO5iCeG0lOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgkYbhK5x2f5mWf8Qzw2vPxUMaj5e4Avq/gsA0YVNzmzuq+6yI+ADnSWZpLa/b4j1nyr8a7ZIFDtQ29vuUqC1ogsthxwpq1257LiM2CVg4KliG6xOOv9jPQ1q5iSfOuP0UL5okPvTOhMF1xEL2u3d8E4H+WX7z/pid5tvB0/boY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EehsUVX3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so1009108a91.3
        for <linux-efi@vger.kernel.org>; Thu, 29 Jan 2026 09:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769709248; x=1770314048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRBeS4+WQmZOEFMKUG8W1VxyeXhFlcnz8q11qIvwb5g=;
        b=EehsUVX3Mtb1zJY2gmfQL2uobA3KUhB9yr/ZBiJV0UF0o8nd+eHAIvDusYLSC1wl0x
         r/mBrJ9tkAbq9ToAd8mPCICE8EVVHPJ7jLrvXgXK4Lypenk8mFMtfLYttJj3ToNgR1eP
         04d7mllMSkQVuSk/ReDixHcLpkpT4TLGnjfzuGfHsJVEAVvJOa9sPO5fVHovwiBkc6BY
         qg5TVCNYKb41/VUFs2y8M/tSpt+V7PWl+Klyd0HowUh7BeHgSbEC4P70mmt6z/dTXfM3
         upYZwKy9WzFh/FoJMQ707y+CdaxIcV+GpMrM5EOV5P95NHIsvvAf9HgJDOYTEs4MTd6H
         VHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769709248; x=1770314048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pRBeS4+WQmZOEFMKUG8W1VxyeXhFlcnz8q11qIvwb5g=;
        b=P0VT9u/5ij00YVEvLulx6ubEjXKA/0wRhDI4IzgjgulwDCWffQ91PK8+g3a/PXv2ds
         l8x/O9/8DqnMx/HmkRlbRhgJ+NNrM6ESufUQ6S83REaBU+nfDc23T8TqQ3dycO9lMQJD
         /gvRaaP7QEOji45HBYzlRR7JZLYgSDkbncg1iiMABbwgVtU+quiIzNC1Gm8nBJniqVyP
         Rz+bZ1ZOChklfVrv0Oi//I0r/j26UXL/bUmWSdOKGWaLqFKy6S9YdKIlxUbXsfrJruSJ
         YXTHa6HCrK7FrJBJbQwg1wnlI+RFuVBsMAzkQoFDpexk9zN0sVz+uSVHY6UA9LXvldbF
         QqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWezE+gGpFoDPLC8O7/Oy73WFL2truEDQXtm3+9rZNxpJqSEBhU2byhK4cW1TvFwU7wPiunbQRuOTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1q+WRPDo7+K0nFBFcBEr7TvTjSK5ekftHR8ys9QiOy/qRoJYo
	2TAAsd8DG5oysnz6XxhAsXkvVTiJdi2iGeFzdHkvvkW4kxOUN9vkzhA=
X-Gm-Gg: AZuq6aJ30Kgu82nPlk6dbwwTfIp08LcY5TrWKmYBnAeABrHI4yJAeVbHbHf2k48MZ9G
	NVSQmVxPDBbn3MaIFOYzgmpYhEsMcx6jTvuPwKU16iYBpDEQAxNOC710HdjfX5R38NU0nfwhJKA
	UJpxFV19lvJuTkSTEU2EDBosr7jjzHLCUMBigbJ1+/g6vAVn9HfXSr2vISFE5XFIj1QoiMTOZX9
	+hlvdNmSTMzH9sQ5H0wIHAQNFeXwDiF96OOR+qok74zjwlmUsvhrSJluO03LDRuWEMBaSPvogBw
	kOLNrt7fSPvjOY/hHsgktBUh4Vsuf2XMsOKTA/pEeiAc6GY+BgjdmdAeeKxs0EyIpxwL9ZKtEcr
	de1+0apQcu/xcD9m5oMc//vIL3GHDTjl6+bElX9gJF2okYtHuvN5sCz555dqiy9e8E0oBQH7zji
	uXr5WFQK72s8mI
X-Received: by 2002:a17:90a:d60d:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-3543b2dc1c9mr291029a91.7.1769709247945;
        Thu, 29 Jan 2026 09:54:07 -0800 (PST)
Received: from at.. ([171.61.161.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cb5adsm5952303a91.3.2026.01.29.09.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:54:07 -0800 (PST)
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
Date: Thu, 29 Jan 2026 17:53:58 +0000
Message-ID: <20260129175358.1100-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aXs3XOYucVna8eGH@wunner.de>
References: <aXs3XOYucVna8eGH@wunner.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6055-lists,linux-efi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42DCDB3462
X-Rspamd-Action: no action

> I don't quite follow.  The patch counts the number of GPUs and
> uses the set_os protocol if there are at least 2 of them.
> One dGPU + one eGPU = 2, so the protocol is used.
> 
> Am I missing something?

Well your not, and it was a mistake of me, which i apologize for.

but i still think a MacBookAir dmi check would be better, as
theoretically you can connect a eGPU to a 2013/2014 MacBookAir,
which would enable set-os, and will cause problems in applespi.c

