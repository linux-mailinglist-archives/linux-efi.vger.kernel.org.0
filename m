Return-Path: <linux-efi+bounces-6031-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMpMHpCEc2kDxAAAu9opvQ
	(envelope-from <linux-efi+bounces-6031-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 23 Jan 2026 15:24:16 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37376FCF
	for <lists+linux-efi@lfdr.de>; Fri, 23 Jan 2026 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C5A30136B8
	for <lists+linux-efi@lfdr.de>; Fri, 23 Jan 2026 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640428466C;
	Fri, 23 Jan 2026 14:21:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B61F4CA9
	for <linux-efi@vger.kernel.org>; Fri, 23 Jan 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178077; cv=none; b=My8lw3HRq+fqHu/RyzPMM7VA5EDCtHSJfa18th8p2wsDoO4w+hLkhPJFR5hd6XX3JloIqW5+l4x4qV23zgj/YCfg03n5bNR6WBGnSXTQHJqv/PRO1+T1IaYUuKgbbYcrt25gfXGyCt8mMsh25fx3UfXAJVWdrz7/zmq8rZOoTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178077; c=relaxed/simple;
	bh=gF56votJ6lVEzOEG3i3V0u2uxT9pnpCxbTuCLGxdDSc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DX2uNA6v8LEyqp7Iaa41jvyDeHZAnMohlTBvKj4qpnHaCnHE1U8JVHeANrerGBYzeFXAUnaIh5YUtr/JJjs8vJkY1TP8I+wVA4G878K5t5Bq6kQN/jK+kwizQxE88UvcSbmV34bN8zdULDnqyNBplmHl6eTSmkg7SxhRVE9gmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64960418d46so503175d50.1
        for <linux-efi@vger.kernel.org>; Fri, 23 Jan 2026 06:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769178074; x=1769782874;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+loxDmXWUfE8qg0dJhJT63mYbwODNY9/grusQPAM1Q=;
        b=N6CTCxuYyybxb0cCVBSdedgQebjZEiXl/Q0ccY0BMKpyp2BOTTW7T6jIk0VYHi5SNw
         ffHCuGPsnqQUJSbCeEdX5luGBEQi3OBChDUzmk8QpGxmTRM33b47IQSLlY9MoRzs/XPN
         JL6yK38KHLMj0+zig5+Ghcec9N4fNV/c97fIzuT2E8qyFeqmhLyWiz5bIAezvVttoAEs
         xV4E6NR93tEqN3bVoqkjoiXBTaUrxqJ0ao9CHu4X4qb2TUPz9XamMJ5xws6rz1lHkysL
         QCaMZ4LhlQPlGqC/uTPsCYL7wdWGoWi/vECOgGCY3R/dH5dqLSMz7jmEC86nyZvXDyFB
         23Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXcSUclb2Gw8zF0wOO+gpjrtuMscKAq2vf/52zzYYQpqfCtrwot7t8NJqLNshAZTcio5O4NfA6aN6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsSLAtc5XQp+iot2u1hoC2OA5/Qkmo1QrF9TChRa8sdwhhKQ2
	NdeF8fojF57OUox+Sr1QQlBS0NGDpUFBr8euUlHYXevvLEjkSaPt2GbRI4bnCMEXqXbaIQ==
X-Gm-Gg: AZuq6aLmOBhoh3SvLuKGZc99EGeEfLNER94JlB2lhBoMx8GNgFEfp5MS8+lgYHk3ACr
	Yv1HLBpxqid8dxuE1p/OJtCg0yW4ywYEkE4+uIDght3s/St7o+N72BnjIunX4eWyvEd6pUewTJl
	14TOnlP29FgfUwuyf3mPMvc3LS7fStQ2M//klrykj/TrkyrATh9qCZtNuZ4AxWqPJQhSg+ACt15
	scz6dkNCfjrgfwubl2z7z9HUPR656TuiWoFgI+QuTut9XpYWRhv0kjXPK7FBSU66JH8jmuqGvem
	14pRmXhir5kTa5OGrV0lTTF+4cVjNOYtBH7w2Hy/Xb1YImNjPPQaZb+2/9CK5sgKwOUsOpDjbb7
	aaqsuUkRkWYt/JSLsPXvvmzGH9hCdWm1P9Vlq4pCVgvyL/yQOzs9MjhZcGTZ20TWB8WH8ms6PYW
	ku0bulq+35DjOIpwui6jVmHZTRF6eMHqgs/VeYuP8nE1/E9a4=
X-Received: by 2002:a05:690e:4004:b0:649:2959:fd3a with SMTP id 956f58d0204a3-6495bd61404mr2448299d50.0.1769178074262;
        Fri, 23 Jan 2026 06:21:14 -0800 (PST)
Received: from [192.168.200.2] (104.244.95.48.16clouds.com. [104.244.95.48])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6495ce7840bsm1227940d50.4.2026.01.23.06.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 06:21:13 -0800 (PST)
Message-ID: <15576657-707e-4a8f-ba6d-67063eb9e9f7@kylinos.cn>
Date: Fri, 23 Jan 2026 22:21:10 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ardb@kernel.org, linux-efi@vger.kernel.org
From: Ke Sun <sunke@kylinos.cn>
Subject: [RFC] EFI runtime Rust wrapper support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-6031-lists,linux-efi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunke@kylinos.cn,linux-efi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Queue-Id: DA37376FCF
X-Rspamd-Action: no action

Hi all,

I'm working on adding RUST abstractions for RTC and rewriting some
real RTC drivers with them, such as pl031 [1] or rtc-efi.

The rtc-efi driver uses EFI's {get,set}_time methods, so I'm
considering adding RUST abstractions for EFI as well. What do you
think?

[1] 
https://lore.kernel.org/rust-for-linux/20260116162203.296844-1-sunke@kylinos.cn/

Thanks,
Ke Sun



