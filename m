Return-Path: <linux-efi+bounces-6050-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDPDD6lDemmr4wEAu9opvQ
	(envelope-from <linux-efi+bounces-6050-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 18:13:13 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7215A69DB
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 18:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFEDD300613D
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE1308F05;
	Wed, 28 Jan 2026 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4r/0xcd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02A264A97
	for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620390; cv=none; b=luZz+fDBgO6I7ExaCN+Qn38We1FiFnocui3UrAF1kC6oWgUKkB5jA2E8fdrRsia1RSOPcqZ+WeJVOiOl39Q9gauDE1hc3VLEsYpF6RQGJzzkXKiQ6PcOAX1LGRdX3wRaqAAxoAZmrMB3gSwfsF3mPYiLS+QyA4yfXa844a7Elt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620390; c=relaxed/simple;
	bh=T4XRVAVRdVWMSRhn3MB3DspTpLQUZKbsniVFEUzhmTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l33FDKf2qkpV8vUTqN7J6MjxXpkQOIdst7qT/rST38Q9xn5SZuEfub0UTy3Y5nYDFllbDFZ4HTmOTrnGqFG4yg403iQc5F6U/XKuM02XDBfsrH+Rqb6+3TEeefI3afV/pKLYN+UI3hgbdr4/dsTMW6cju2iqCWoK6H7xq3ENDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4r/0xcd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a871daa98fso72705ad.1
        for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 09:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769620388; x=1770225188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v536dPL3xbsn4C25/q600c85aXwSnqGccGF9Ndz/vck=;
        b=A4r/0xcdMIfgKfht9GBo20u+Bb63H+hmo8SnSH2Z40k4WGdhm8dO0SP/m//FR2JbnJ
         NN+vIkdfhHCBJrpNp8pom4dGYvFtAznSvOP/JFSt1j4lB+dX94vAYCbESIS3D2rnonfY
         hhe7tfUuUn+RDZ0f2sQHCRHm5nPkdmFVmClxae8AcintXETYZo9Y/Y8q00LcLd4mZJF+
         SIDT6fI1eeA/PSGEOQKDWMPbf7Rq6NPVdM/BpK4uE8Ei8a5ZOuPkd7iQaFa1vIaAQQHJ
         RbZlKpFu4GpqnGp9Y6s3VzFILrL+fq7b9apX1LI6fLnmOjyZuYiHPnQ67CCoLlNIQOQc
         feDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620388; x=1770225188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v536dPL3xbsn4C25/q600c85aXwSnqGccGF9Ndz/vck=;
        b=k7PsA+6Qeyooc1jnqmgQQwrwY8xSX9ekoKy1ossGtyEeL/zzXnb9Ki98K8OgseGczf
         LZTB4ZJR206Sn1JvrROtKRmkJPtK5uZKRrVio+ufF2XkVBWDH772DaexXXjQhpsG6Uva
         6HHuowWzSjXuSA+9NjHRrcnP51i+C/wigYxXIotxK3XJXwb8rSUEVDGdX2mxYGlyPdTt
         6DezRTEVhdlJ+0LLcffJVoy8go2UMtE7F6/DhSx0RHh3Ye9Ew0ibYyRBbTDJgXQ9pjMp
         kMYGMQ7Hvxm0w9pbgor1FYnxMrVVVIm+gbF+tr2ks6Pz+1egtY/ae/c9zwROtf0/lRp5
         0o8g==
X-Forwarded-Encrypted: i=1; AJvYcCWub0RlaI22+4ZSUVYIzX/uo2a4rkQUm2tSzDurCFKqucokP0w+Ksnqf+JKvvD7KgXJW9g2V0YTbKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLucMtaMSt6hHRG+DZ/SlYo9X/Yxy/YPynU+OAZBk1Wjq3rRCD
	op8qgQHpb7KJOyEEqWAwoJQOFd+ERYPxzXNDn7ecqpdOawCcvs56U8k=
X-Gm-Gg: AZuq6aJ2lUS1YzWxshXkH1DiY1qMRd6W3xsugYd1e+S/93CNlgdee4WLIeNHoMD+9EZ
	NUinHI+2+fFHQekidsnDv7pLAJ0QRxOsP5Ue9uISipkaDth4TIQhwv0awvhs5yjgZWdIkJJ0Cph
	MOGTmxh7v4WhF8J+4GwnsjLOYRX7+k5aM5I7moyG/ulGrgn3asXXAfJpuuQmvTmEHr39Fv2C/PX
	vLf0sNyC4W1grKk3WTwUCsUejcQEKeOf4iU98ttg2u6kV7ud/c5/oaTLYIwZK+ErOo15k+qVaGy
	5Kb2GZAwdsKHmGtOeAT+GpClJ2tLS3HnIKiCM2Ev85gAshvqIyDBn9VLi5ifGnUVphnTeVBxhk+
	ot/d2jOVlmyPgRVdJQqD3MV72nrZoDNrEpzn61rby3rx3Ajx4peBQTFT3h4umprngHema2Caj5m
	UaqEuSPej7X2tD
X-Received: by 2002:a17:903:1a88:b0:2a7:afb2:ce1c with SMTP id d9443c01a7336-2a870e18dfdmr60392705ad.61.1769620388192;
        Wed, 28 Jan 2026 09:13:08 -0800 (PST)
Received: from at.. ([171.61.161.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd74e9bbsm85105ad.95.2026.01.28.09.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 09:13:07 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: lukas@wunner.de
Cc: airlied@gmail.com,
	ardb@kernel.org,
	atharvatiwarilinuxdev@gmail.com,
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
	mingo@kernel.org,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	tzimmermann@suse.de
Subject: Re: [PATCH v2 0/2] Add support for eGPUs on Apple Products
Date: Wed, 28 Jan 2026 17:12:58 +0000
Message-ID: <20260128171258.1081-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aXoxpWFE0rByjS-y@wunner.de>
References: <aXoxpWFE0rByjS-y@wunner.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6050-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.freedesktop.org,linux.intel.com,redhat.com,vger.kernel.org,intel.com,ffwll.ch,ursulin.net,suse.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7215A69DB
X-Rspamd-Action: no action

> It's possible that the iMac has a multiplexer built-in which can
> switch between the iGPU and dGPU at runtime.  Please ensure that
> you have set CONFIG_APPLE_GMUX=y in your .config, the gmux driver
> should bind to the multiplexer if there is one.
> 
> If there is a multiplexer built-in, then disabling the iGPU is the
> wrong approach.

I was using apple-gmux even before this patch, and runtime GPU switching
does not work on either macOS or Linux.
On macOS, the iGPU does not even appear in System Information.
However, the iGPU is present in IORegistry, and Apple appears to use it
only for acceleration, not for display output. This can be seen from
the following IORegistry entry:

    | |   | +-o AppleIntelFramebufferController  <class AppleIntelFramebufferController, id 0x100000556, registered, matched, active, busy 0 (230 ms), retain 8>
    | |   | | |   "IOClass" = "AppleIntelFramebufferController"
    | |   | | |   "IOPersonalityPublisher" = "com.apple.driver.AppleIntelCFLGraphicsFramebuffer"
    | |   | | |   "CFBundleIdentifierKernel" = "com.apple.driver.AppleIntelCFLGraphicsFramebuffer"
    | |   | | |   "CFBundleIdentifier" = "com.apple.driver.AppleIntelCFLGraphicsFramebuffer"
    | |   | | |   "IOMatchCategory" = "IOFramebuffer"
    | |   | | |   "NumFrameBuffer" = <00>

NumFrameBuffer=0 says that iGPU isint handling any dispaly atm.

