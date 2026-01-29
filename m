Return-Path: <linux-efi+bounces-6053-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJLWFlDkemn5/AEAu9opvQ
	(envelope-from <linux-efi+bounces-6053-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 05:38:40 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE066ABB60
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 05:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F401F3025932
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 04:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2327F72C;
	Thu, 29 Jan 2026 04:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4/5Pu0f"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5228B4E2
	for <linux-efi@vger.kernel.org>; Thu, 29 Jan 2026 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769661490; cv=none; b=L0VZnyAiYE1Qmj9ilRVbU9QM4+I3tbOcwr/LlviTAFdZfTkio16L5vvwP435CXefOlJVjw0fwV6lS0uKFToMnChqEcfFORwyOR4NB14q+F7jjQFcynMogYLajWl1dn1bC7ebjtMEuBNRrbXGnXPPMrq7J2qrbymPcy6+Sg1cnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769661490; c=relaxed/simple;
	bh=yf+FiMdc1rY88Q0DWo4VQAVVZ2cQ1LjAULfhSCdGuRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8Wippw8Mz6wOeknCInBC9UIg7R1gJUcbp6KvSeE6jTutfuWAOYyQj3UP847LdR7FQ/BGXSkPg8+yI0o4ekKQD6VzimFrqwwx8IrYMCmFkt2YQ16ZjfK9TqeSAwjXoc9PkFT41CGaaCEMup/Y1yfmZtrNPFhcCpjfQR5vFgX5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4/5Pu0f; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso195967a12.1
        for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 20:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769661488; x=1770266288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtQGOuC29uzt/6xaJHUti83+eOwCdLjkcvzsqNsGu6w=;
        b=L4/5Pu0fBa1blODFippLsExzXqWaExD+mzE9xXnpwrc1OeeZ7wAuZS/Ha6j/JssOga
         nGpiZBQZKX1/NAvSnwr3eLkz4XK23gEqbRdA4ehJjVoqcoDAmt6TPPZyMGkyPwMx/02b
         3LoQMjzQupY5JoSGh/m5msNJHkVhMmRh7Qi4a7sYjx2tThNL067NDdAvF9AMaAz+Y8XB
         kd+WDHZHbXO39PnRSpHiFCMYuFSimmqDuGo2C5Z4j+/QBzWLVvIV2TEc8JoElVOdFW+w
         uhvNMXkpCNnomL+t60Wgzb0hhXKoeTb1OxFXzIvbJk6GZOU490PiafkPyiJzGH5hKkcE
         IAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769661488; x=1770266288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtQGOuC29uzt/6xaJHUti83+eOwCdLjkcvzsqNsGu6w=;
        b=QlQ+R8Iw6plNSf3wpSQr0dTP+9OEFXi+JMN/n5GUSDgRJfeRs0GFFFee88SRu7tTlw
         7tBImVLBGxRmuJKQ2giCs15oxR5JFxYSrClbWkz2uEgW+ef/RtHJQjS446fBfetCjGCX
         Zq6CcRTqLXKG3fD9/D/jjKzcHVV7fvtL6AJ5NAKvgmtPQVTBZB4RIgIr3+puW38qv6IJ
         OYEQUBxPmU3LXKw528PgLXS/4LxaFnre0H48IWjW8XsdDsHuetxjdkOXY6kLHpG5iaxR
         QjzPVPSnjjxntw/cknODos3YFFMxKxwXQm+4HIxJ5jFf+GK/mPangfkI/dDCg6+a0iZl
         cUEg==
X-Forwarded-Encrypted: i=1; AJvYcCUCqop5/PuOFk0j8y5Pe11dxPxRtvri+Qwr6hZdy1Gki2q+qplc5xz+GulqFVTNBdbKtaW2Hwzzq+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YztkxYLgnaaGaLa9xz9y842fJsOJy4B6BPcXJqX4cKXTkPNvj/i
	f3MxPI6APQ3f3YZhMvz9v9jo+fBnqm7wPlfvI4TXOcPQ5r5JjJ22eZc=
X-Gm-Gg: AZuq6aJo7SyyOS7KdaprFWBbwZ1U0l2P1khLQqwTMzLzmdwKMEHjPc+5b54WUM/ZGNY
	i9VZDIYTyFsgl/PMb1I4qF5+xPOtKAjGrPBHRrHbkGtWtQpSCmBk3y/+WVS3SbhkNNsNcGGrYbb
	Miz6tpQ6oUXKCVT0GhDR+DfiE/WqcUn+2xM+/zVNmlwULowImWJ0KowgW75kZFbYTWcSxMptQpp
	ryb3eYa7hHjdlddprh8J3g3V2iDIl548kmm0cyG2YedcXPcxWzaikt0z8N3lUlEqoGPFOcpwa1n
	asFnA3WXJWOnWRtbawppOp6jgM6pPHqHjkT/OQy4xeFpagwNrWLF6KEXsmKni5amFVqEi4BL6H+
	JhmNjF4lh/zhI30LXm1F288f54klmxod7SaRcZLwzGQ1a/Ye0O9t2GtWYDEZIU5epO7hnUVcRBH
	4iFdMsIz+pkFJs
X-Received: by 2002:a05:6a20:2d26:b0:38b:e430:156f with SMTP id adf61e73a8af0-38ec62c6411mr6930473637.20.1769661488418;
        Wed, 28 Jan 2026 20:38:08 -0800 (PST)
Received: from at.. ([171.61.161.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6427e9ce21sm3595710a12.10.2026.01.28.20.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 20:38:08 -0800 (PST)
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
Date: Thu, 29 Jan 2026 04:37:59 +0000
Message-ID: <20260129043759.1220-1-atharvatiwarilinuxdev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-6053-lists,linux-efi=lfdr.de];
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
X-Rspamd-Queue-Id: BE066ABB60
X-Rspamd-Action: no action

> As discussed previously, your patch will regress older MacBook Airs
> which use SPI to access keyboard + trackpad if the set_os protocol
> is invoked:
> 
> https://lore.kernel.org/all/ZoJPgSlZJ3ZlU2zL@wunner.de/
> 
> The last time this topic came up, I suggested counting the number of
> GPUs instead of using the DMI quirk.  I even provided a patch but
> nobody with an eGPU bothered to test it, so the thread fizzled out:
> 
> https://lore.kernel.org/all/Z6paeFrjdv7L3mtv@wunner.de/
> 
> Maybe you could give it a spin and verify if it fixes the issue for you?

I tested your patch, and well it works (you still need the 2nd patch to 
avoid a blank screen), but i can see how this will fail
like for example, with the iMacPro (only has dGPU) you would need 2 eGPUs
to turn on apple-set-os.

My opinion is, we disable apple-set-os using a dmi check on the 2013/2014
MacbookAir models.

