Return-Path: <linux-efi+bounces-1499-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8193E501
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jul 2024 14:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A676D2818EA
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jul 2024 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC736AF5;
	Sun, 28 Jul 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT2ocOMB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628E8472;
	Sun, 28 Jul 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722168239; cv=none; b=ELPfnWN5RFyJnKNZweDkTlV9xf40/XRmlG6ssKAWXICh+WgpJaIt80J21KRKyp+Oi/l+ONzxVM40CkguC1hbMPm//hSR9nv9xaWRrD7hiHKMc9f+27WEJMATJxDQJ6NiFAfdY8SRSVy87VI9Xay4qPMRaRxRza1aRehVePWujo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722168239; c=relaxed/simple;
	bh=F8PaOnA3zUR3FMKSXiMCYQEDuCoiveduEvjrihVJMrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=Z5XOwKJhAwKZTSeqdcSfFzVB6WQnIusIerwfZOlB/uGZCftSyRcac9ASkrM+anIIQr2MOCeQOqhliVGyh1pwMl9SkbPFkOPttU93u6JytG4uJvrz/KAaiSWbB1vRe9CoRWC62pRZ3OQ4aZVlecrPSs2HG4m5Jz6vRLpdDoRGJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT2ocOMB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd6ed7688cso14593115ad.3;
        Sun, 28 Jul 2024 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722168237; x=1722773037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=boH0xEdMoJBl/xDSFozf4B1Bjk2T2kBWYsRSBAPCCEA=;
        b=CT2ocOMBJwULnB9PaFfPv71aJMnFmz4vzgvFwLDZOoc3HWQxm3oEG8di5+sIKUs/5q
         oJ1vOPUKVqEfAVvLV/oGoYnUa2XRarw4InQqk9jTjapiP9cQEmwOY3kXg9dpwcToiWZ5
         leNVEhxsfnipnw1JIikOX/Xl4LvCkOH9ciMRF+h7qHDl6MHUOxtWKgrazWnHdahPpDpd
         l15YZqb9CIqgCFhKRqPDLK6cXZV7hu0vnjmJyDz0UrprAjbMmnJNg7GDriziLzZNDvpf
         LnSYiQNWax55FwGXirTIXJxNIGdBnA1xOAvr7/8m0YU6bFpKYTalT0ZIal2H1Cxx2zcZ
         HH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722168237; x=1722773037;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boH0xEdMoJBl/xDSFozf4B1Bjk2T2kBWYsRSBAPCCEA=;
        b=u9uw+AupIXw6tK0IkcoNjmbC7o+XZeOSJpz5nG440HsxDJQ3ldMJHlxiqTtENLqMfP
         UkNkuMINw7t5Bqwx3gNw2hG0+aUPU7ElCH0YwBLWPoUaA6mzfTOBWhvh6p8qWD7dT6wh
         c+GnUnPF0OQBw+SxDwz9R+pysCrz+gTXRhhLpvWgzkGqjhW6GD9U8+NvyfvK1C1DUOSz
         15wIU60iSbKEAiCdODSrveN589Ga4L2STdufe9lzP6IXsAhbccZIYwnoafRuetlEbLUV
         JHflP667T5zBiz4uRg2JMW95I+x36HBLiWZvmxojJBZp2J2sY0MtUbRsdvze84qCrtlx
         oStw==
X-Forwarded-Encrypted: i=1; AJvYcCXZdXtL7uBTP24M78RHdw8oanWn6mC2vEky3Uy88aYnoKRwmWJHakE196wZxfDX7hIArSmUSdbUwqTeT4HP7MNlirB2wOdkncgEJM9XsPIpd0XcdXWWK4bfW7CeFr1g5exLWwMo6z/2
X-Gm-Message-State: AOJu0Yw6wzV2Io2URFiavOgxkehnRfAe1HJ2tAKMTrWVS/uVJ/UsFYS0
	kLTXBl8MtABUpX1sEBwBIP54vVvmq3+jkVCP4Tm76FzzJ+FYQAkY
X-Google-Smtp-Source: AGHT+IHUljAZZol/wS5ziZTH5hbvjEMMQlUbG5ZFUG/1hMckLUH2/m5GC+vEqGEx8W4hj7IXV9//GQ==
X-Received: by 2002:a17:903:428f:b0:1fa:fc6a:858a with SMTP id d9443c01a7336-1ff04828ffbmr25912265ad.15.1722168236975;
        Sun, 28 Jul 2024 05:03:56 -0700 (PDT)
Received: from redecorated-mbp ([203.221.213.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d3947esm63935125ad.116.2024.07.28.05.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 05:03:56 -0700 (PDT)
Date: Sun, 28 Jul 2024 22:03:43 +1000
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: lukas@wunner.de
Cc: ardb@kernel.org, gargaditya08@live.com, hdegoede@redhat.com,
 kekrby@gmail.com, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 sharpenedblade@proton.me
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Message-ID: <20240728220343.40fc64f7@redecorated-mbp>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
In-Reply-To: <ZqElRH38f_XV3fKK@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 18:01:08 +0200, Lukas Wunner Wrote:
> On Tue, Jul 23, 2024 at 04:25:19PM +0000, Aditya Garg wrote:
> > On Wed, Jul 17, 2024 at 04:35:15PM +0000, Aditya Garg wrote:
> > > For the Macs having a single GPU, in case a person uses an eGPU,
> > > they still need this apple-set-os quirk for hybrid graphics.
> > 
> > Sending this message again as for some reason it got sent only to
> > Lukas:
> > 
> > Full model name: Mac mini (2018) (Macmini8,1)
> > 
> > The drive link below has the logs:
> > 
> > https://drive.google.com/file/d/1P3-GlksU6WppvzvWC0A-nAoTZh7oPPxk/view?usp=drive_link
>
> Some observations:
>
> * dmesg-with-egpu.txt:  It seems the system was actually booted
>   *without* an eGPU, so the filename appears to be a misnomer.
> 
> * The two files in the with_apple_set_os_efi directory only contain
>   incomplete dmesg output.  Boot with log_buf_len=16M to solve this.
>   Fortunately the truncated log is sufficient to see what's going on.

Hi Lukas, in case it helps, I got the user with the macmini and egpu to
get logs that don't have the start cut off [0].

>   We could constrain apple_set_os to newer models by checking for
>   presence of the T2 PCI device [106b:1802].  Alternatively, we could
>   use the BIOS date (DMI_BIOS_DATE in SMBIOS data) to enforce a
>   cut-off such that only machines with a recent BIOS use apple_set_os.

It might be simpler to match "iBridge" in the DMI bios_version as this
indicates that a computer has the T2 (aka iBridge which runs bridgeOS).
I don't think there have been any issues from when the downstream T2
kernels had apple-set-os unconditionally so it should be fine to enable
for all T2 macs at least. This would exclude the T1 Macs with possibly
missing trackpad dimensions in applespi that you mentioned [1].

On my MacBookPro16,1:

$ cat /sys/class/dmi/id/bios_version
1715.60.5.0.0 (iBridge: 19.16.10647.0.0,0)

[0]: https://gist.github.com/Redecorating/8111324065016363223b5ce719e48676/
[1]: https://lore.kernel.org/all/ZoJPgSlZJ3ZlU2zL@wunner.de/

--

Regards,

Orlando

