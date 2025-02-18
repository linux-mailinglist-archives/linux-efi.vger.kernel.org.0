Return-Path: <linux-efi+bounces-2797-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B03A39E28
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2025 15:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E4188BAA9
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2025 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3165D269B17;
	Tue, 18 Feb 2025 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Um3ATsac"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BC269822
	for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2025 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887286; cv=none; b=Bh9okc22urT1PzaaeoY1LANMbepMPWW1dfGb3RpknFE3zSZp77a2mWbWcnke9+sW2z3RlREHFcJK9EWa3KkVL7+Uf8SWC9EU3fLdcynvBqOQWZxUtu6oFTEPGaTdOph/LJHFEMraNN9d5mk5JF5o4NyUINNrYLZIoXcFxllljjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887286; c=relaxed/simple;
	bh=CUUtLbg/V9NQg+AuWoIWQTSD1MxC1DHpXmOuggSU0+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEicPkTO6C+6UYAMG1XwajGbelZTXRJFAGWLm/En7myjR8dNnmnb8zyga1Co36IyVIRp/rQc7CHOyv4/TbWutW6afE2qKc8tlFbFnUBWKNONKEADqk5SAyVdPKVkuTAP95dtDfquCuCdK5XwAnSL3KRzENMYYBs27s9Z2uqjZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Um3ATsac; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 927443F47B
	for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2025 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739887282;
	bh=9baZ8MtjuJOAuAOdwVfX6siiAQJttTW47fGC4JGW+8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Um3ATsacydxoajA+6qIHvR4BppeUUPmI01GQZzKcZbNTol5o3hADsUFo6Vmv7itRb
	 gif8NAABp+zxCIvnYQlpv0IK8YJdwjzn3a5EL62HtGHIjtgfaWluZu1x+jUwJ8yspI
	 yKIuRsYVh5WcaWNmMo7TekLf6h+VpvryvbWLKksezxM9qT2FXtk00YQEuIm3MJ5yNc
	 e4cV3qEcgdAFhxx/qrU+mBwrDqoVKU3lwIkib6na4qcVUM/+xlPdOI1I7CTyxziqfC
	 6wygwWyRoZygc9ZZ4oUHmIktj9S6w0AlcRnULKdDN7OK33Q7Zwq/82yjvprjO9kJVv
	 Y1C32bK5MCTkQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f4e6e004fso1572260f8f.1
        for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2025 06:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887281; x=1740492081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9baZ8MtjuJOAuAOdwVfX6siiAQJttTW47fGC4JGW+8U=;
        b=w6m0AsNi+XcrOOXnvwLe6vO1FCk+ZSSpg3Lp2o0ziIXGBHZiwG6b5zWDHfbPaeicjb
         Ei4UkWQ3wKM5Fjpe2GaVsoDBozBzSX0kk0saH+KGEP8G6V7DfZETs13iegc/MAxsCq1T
         OakgJ1wM5v5hZXY58Fwh1YvN4eQoxdwwiX+Gnut4waG1XchuCWX3xs53n8PjXUrPLzvc
         Drk/jodNCtkj31tVhUkffP249wKbhs0+hWSSyug/sItHIXkueTmF4lWB6wmMGTFM7u6a
         eC8ST9KNNCCBGzzA5uXGKlMMAAQ2s4vezP/WS8up0HR7T+vqmLfVs7/05Y+54BZ9+GIS
         buQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL8FAMe1FrVSRmiClZI09Sg6UOxoSyVdUnDIfapjSCTHnEnZL0oJ0h69SBCAnCMsIxvsRZQtGxYkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvKRJ6VRgAWJp3g9FdeEPZVTA4GHvnXjCZRCg3LtgZfH2t9Pqm
	aipjgs0egL/qmaWCaqdosSDfvfRE52ewQofTzYfNJcq7CLbbcVTjA2nu5fq361uzSd4jjWivJzR
	GHHrMDRSwY0Z5XR1Camz+TQ+k1S5z2UmP4+yxqMLlhkgUgJa+gtXybOV36ElQi9sfDfKP1f9Reg
	==
X-Gm-Gg: ASbGnctiRcT5Bt0KfpwgTZlFOdK+D66cAfE+PGSr17Keju6mjuYECvBCdBgZ3KawA8n
	4LSA56iofsHgpE8F+XW/VsakDBzUm2CcVdjSfeabt3WPp+F7ZXN9maAXpJ3q748exopUt3VGUzK
	UrUN0ySt/9UH//o0BrxqZ9hQpokLvD71aC2JbWBT4iPeV6QOQYdvGhKihEPX6SpGIoOHZm6R2VH
	Zh/UFRg2f2oe5I4Pf17PNLxRj6nMp1YAYfb1TqCoahpAFwBh6voQvXpzSo13QKbmG9BlSKuULbr
	AgzE0HdpCnygYqJ6SgEDbeVILqR6exSsXO3oJPnd5NO8Y71Fc44=
X-Received: by 2002:a5d:5f82:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-38f33f14a34mr9766459f8f.4.1739887279391;
        Tue, 18 Feb 2025 06:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3bFoFj7AvC39E0Kp9bB9u3iWm4LdGhfLWfOqb0TEnl13m+51JdBvSgkS7pO5yYT484fKs6g==
X-Received: by 2002:a5d:5f82:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-38f33f14a34mr9766394f8f.4.1739887278805;
        Tue, 18 Feb 2025 06:01:18 -0800 (PST)
Received: from [192.168.80.20] (51.169.30.93.rev.sfr.net. [93.30.169.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd51sm15105057f8f.29.2025.02.18.06.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 06:01:18 -0800 (PST)
Message-ID: <4cac90c2-e414-4ebb-ae62-2a4589d9dc6e@canonical.com>
Date: Tue, 18 Feb 2025 15:01:17 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/1 RESEND] block: fix conversion of GPT partition name to
 7-bit
To: Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc: daniel.bungert@canonical.com, Olivier Gayot <olivier.gayot@canonical.com>
References: <54095d2f-daea-4e4a-9542-f6a2b7603672@canonical.com>
Content-Language: en-US
From: Olivier Gayot <olivier.gayot@canonical.com>
In-Reply-To: <54095d2f-daea-4e4a-9542-f6a2b7603672@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The utf16_le_to_7bit function claims to, naively, convert a UTF-16
string to a 7-bit ASCII string. By naively, we mean that it:
 * drops the first byte of every character in the original UTF-16 string
 * checks if all characters are printable, and otherwise replaces them
   by exclamation mark "!".

This means that theoretically, all characters outside the 7-bit ASCII
range should be replaced by another character. Examples:

 * lower-case alpha (ɒ) 0x0252 becomes 0x52 (R)
 * ligature OE (œ) 0x0153 becomes 0x53 (S)
 * hangul letter pieup (ㅂ) 0x3142 becomes 0x42 (B)
 * upper-case gamma (Ɣ) 0x0194 becomes 0x94 (not printable) so gets
   replaced by "!"

The result of this conversion for the GPT partition name is passed to
user-space as PARTNAME via udev, which is confusing and feels questionable.

However, there is a flaw in the conversion function itself. By dropping
one byte of each character and using isprint() to check if the remaining
byte corresponds to a printable character, we do not actually guarantee
that the resulting character is 7-bit ASCII.

This happens because we pass 8-bit characters to isprint(), which
in the kernel returns 1 for many values > 0x7f - as defined in ctype.c.

This results in many values which should be replaced by "!" to be kept
as-is, despite not being valid 7-bit ASCII. Examples:

 * e with acute accent (é) 0x00E9 becomes 0xE9 - kept as-is because
   isprint(0xE9) returns 1.
 * euro sign (€) 0x20AC becomes 0xAC - kept as-is because isprint(0xAC)
   returns 1.

Fixed by using a mask of 7 bits instead of 8 bits before calling
isprint.

Signed-off-by: Olivier Gayot <olivier.gayot@canonical.com>
---
 V1 -> V2: No change - resubmitted with subsystem maintainers in CC

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';



