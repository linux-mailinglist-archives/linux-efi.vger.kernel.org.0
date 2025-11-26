Return-Path: <linux-efi+bounces-5689-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A87C88497
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 07:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB8D3B2EED
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6E30CDA4;
	Wed, 26 Nov 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JekaNptc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDF2192EE
	for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139099; cv=none; b=Fpi0UaLys5dEY4WQKvi0jj2r3ka4/Q8dw+JE4jbKQ3IQsHqr7+g9pd5wZylMKwHztsGzQX1ATsIU1epzVRt637gaXmZDIU3VbT3KZainAyUxDkJ0HZ9jAp8adwhVUpxyHax+k/5MfGtaSwl2it107jfu5FNBbHV8givtJJ7ntnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139099; c=relaxed/simple;
	bh=IHcn8poodH//FU1MA5VWzEcXDJSpMUbDUfboDcSleBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwD9z6w+cKVXbFKJK6k2wQC/kNdLGXCXsjAscJvvYApqVmTTqaAyv93JfvoLYcwHouJQXVBUGfrv36q27KdT1pjGn+VaWjcpfrQjZG/mp5eC+7BBvkaIytaV+p76u4YWVDSnDkqFrPI8utajBaEWnuIExB19VnXnzCZJ21eIzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JekaNptc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6546AC19421
	for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764139099;
	bh=IHcn8poodH//FU1MA5VWzEcXDJSpMUbDUfboDcSleBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JekaNptcX8SnxevqpavPO2YS78STQdKQ8KyL6PXQWg++Wkk787/8FtnYB7tjzvQJc
	 jB8XmEIHb1v3Ffou0RxHiLfu6gDKclHjI/WCRiWq/eucUmFGxpgQIgG8Jk1/Aj9nU/
	 B0gvE1aTi1WXVd/EK12BYUgcg5lfpkwyPJfJZ3tEQECTIhVz3Rm6Dl9SODIU+pNI9M
	 ibauMdWNSWRAiVYH5AeG9P3qYibeNh0f675lfKOApAjBUvan51a3HfzBQnRGEyKF8e
	 Zu0HFqX1U1k4+YAirJjy5jpnd8nKRZ6pfKK0JfYrIeoXV5ktU4hDhQQCiiVaIkh02O
	 HkiLgwNwNFfDg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37bbb36c990so4580561fa.0
        for <linux-efi@vger.kernel.org>; Tue, 25 Nov 2025 22:38:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXX/K8y1xyOJljCxbhF1kL6WZLZZrBw72V5KlAdgTpunfe9UWJP+yYBqSgVVXGZlWxBdTK2jR3WaxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb88DqLMxyGqbEVZhgZN+FRNP93FcyE+4P2uNgeLBsbecXyKXP
	wxDGcP10XH5n3/G0DV/fuWHLic/lT6ELEWTJIPdO8t8sIpRQf4HHXQcuHN4GYBlgCG/KsLVuy1l
	/we4NB0nF/2svgSlSjS2g9S8OKM7oIcY=
X-Google-Smtp-Source: AGHT+IGgbB0yJvyFDsxvPnqjZKGrRr0GuCZSWkaPRw856NhzHZOODkomFBVO/pt6qkNhS64UG52bzDpH5Ucaj05SyXE=
X-Received: by 2002:a05:6512:2301:b0:595:83d5:7b47 with SMTP id
 2adb3069b0e04-5969e9d3083mr7486321e87.5.1764139097778; Tue, 25 Nov 2025
 22:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031024328.735161-1-maqianga@uniontech.com>
 <f9d632d5-22dc-8b14-8a70-37737a78f206@kernel.org> <37CDF8D84A26949E+cc84e626-911b-40ac-90ef-ff5a2df585a9@uniontech.com>
In-Reply-To: <37CDF8D84A26949E+cc84e626-911b-40ac-90ef-ff5a2df585a9@uniontech.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 26 Nov 2025 07:38:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE0ic5Jx3J75qocFgvUPMqQF4Xsqf4CCnaYggWJ35bUiQ@mail.gmail.com>
X-Gm-Features: AWmQ_bm5Kouy_gNO6ASdM7F_2CcaRjX-XGeBmmg295zd55RvtqIf1wAb-jTzdk0
Message-ID: <CAMj1kXE0ic5Jx3J75qocFgvUPMqQF4Xsqf4CCnaYggWJ35bUiQ@mail.gmail.com>
Subject: Re: [PATCH] efi/riscv: Remove the useless failure return message print
To: Qiang Ma <maqianga@uniontech.com>
Cc: Paul Walmsley <pjw@kernel.org>, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 03:53, Qiang Ma <maqianga@uniontech.com> wrote:
>
>
> =E5=9C=A8 2025/11/26 08:27, Paul Walmsley =E5=86=99=E9=81=93:
> > On Fri, 31 Oct 2025, Qiang Ma wrote:
> >
> >> In the efi_create_mapping() in arch/riscv/kernel/efi.c,
> >> the return value is always 0, and this debug message
> >> is unnecessary. So, remove it.
> >>
> >> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > Considering that Ard doesn't think efi_create_mapping() should be chang=
ed
> > to remove the return value, and that the ARM version of this code retai=
ns
> > the debug message, we should probably keep things the way they are.  Bu=
t
> > if you can get a Reviewed-by: or an Acked-by: from Ard, I'd take it.
> Hi, Ard, what are your suggestions for this patch?
>
> Could you add a Reviewed-by: or an Acked-by: to this patch?

I already queued this up in efi/next

