Return-Path: <linux-efi+bounces-1683-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907AD971B37
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50289281A45
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7322C1BA26C;
	Mon,  9 Sep 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUAZWohm"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AA1B86FE
	for <linux-efi@vger.kernel.org>; Mon,  9 Sep 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889109; cv=none; b=sXk2mrkLtD0EE/ZjhAlvLM5k63bohE7JHCkdvwUOxLVIZ7eEDSIxaol12ITZWA1Hj3XqYw38gWa1Zr0EPAXkxl567Bh9XX52y7WzM26zWmmvGcJGga1IplB7bYh3g0Y2nZ4B9axVrcS5MpsKUd3gvb2Q1G4pq9yhvH/SYWsDasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889109; c=relaxed/simple;
	bh=9j6X+iNrBbGkudgEgQdYUMzONncLc/i8Nz1dEpTL5s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6elRuaPkhaJjAI5F9vjWWw6x95W8/pL/cGxlVXMGyEhi9MNmJRB971OqO6g1/rrMGLG219mQ8SJIM9WA+FoWLzIUHw2OBICunyoDlkZKGilq10wNgrT0Ewxyt6WJTplOPatPYCeKq+EOPI5BreucbTqnobiYCJFDEYNOP1Q7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUAZWohm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725889105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9j6X+iNrBbGkudgEgQdYUMzONncLc/i8Nz1dEpTL5s0=;
	b=gUAZWohmQCC0iCs1UH+D3yAICiHtDsPIKOo8RTTOnH06e/JM81+B4yKE1Izm1IbHNLi6OX
	f1+/1NJ89RzmIwMpVENVTbqCwbROUAm2zXXW7ZxDIis+PDCNubegtwu1isGOZloz5P7d8K
	M4K3GiwXP9RZ3Re3gRW/CxpG2A16g0Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-2U172KEVMUK3vUqyOrNSUA-1; Mon, 09 Sep 2024 09:38:22 -0400
X-MC-Unique: 2U172KEVMUK3vUqyOrNSUA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c51ee031ebso55663876d6.2
        for <linux-efi@vger.kernel.org>; Mon, 09 Sep 2024 06:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889102; x=1726493902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j6X+iNrBbGkudgEgQdYUMzONncLc/i8Nz1dEpTL5s0=;
        b=puNYVrzUrctUyvKtEjPHS3vLZQRYr1id5CcG7jJhG+5rgZGQ+XnszJeO6KA4+zK/Z4
         7CaeyMxlbogzUA5EPsTl252IC5M1H417zMDhYDfCx/2yLSCcyWr5XAJRUiQRIV4L8JPt
         /xgk6glUNCDVG/Us3t+W23IjvCX19jBmFw1llCCcEpwKQZ8EznQcGlILO9iLB0H6VjOm
         K5IJ48cENapJNO5MF0vMNa4isVbO4p3WhCQQq3yv8ZXfyFpyvJUO5nL+6Fh0mQeMYzX2
         MgwMGTzwKCgguq0PPmewmliybkLEhORa3PjMowYuRHwN27NGg7GsKT5OnhMwBY+P54rQ
         rBfw==
X-Forwarded-Encrypted: i=1; AJvYcCX2e19RH/aiJliSwjy2TPivZiJes0I+xXH3vm0th62P0DIfXdjcFR565DW3tFX8QMTm9EgS4CbgMYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPUBLxL3xL/JCllH8hPXw5mraHkqJfJYHmtE00LK3ZihSTyeD
	DdauuS82ymayuSgEKiHsF9AEBiEui/5AfAZ8+1QvJorKVVUIMonwCkYl+e1N3OBPfQ8iFULeKwU
	psCxf9dZ/n8fiNZ6G0DlAa3VP5Hv+koHxPb9GCY8izB4GUMdVgMWW2iT9jXHl9I+wrCdQwv5BDv
	Muyr+bCqqAeCflyi2pELSkLxLd1pHOWUex
X-Received: by 2002:a05:6214:2b9c:b0:6c3:5abb:1f9f with SMTP id 6a1803df08f44-6c52851da6cmr150547406d6.36.1725889101987;
        Mon, 09 Sep 2024 06:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2sPvjJoZOa9K6fNLHKcOOKgCsR4l1Mq7upihYX1Ngchdx0HTX3QgXPqTS7y1mP0sxXTpLxuUz61lxQFp0FfI=
X-Received: by 2002:a05:6214:2b9c:b0:6c3:5abb:1f9f with SMTP id
 6a1803df08f44-6c52851da6cmr150547116d6.36.1725889101648; Mon, 09 Sep 2024
 06:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login> <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
 <ZsyFr8V6yizMiBTw@gardel-login>
In-Reply-To: <ZsyFr8V6yizMiBTw@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 9 Sep 2024 21:38:10 +0800
Message-ID: <CAF+s44TkqcpA9oQPy5BxV7mAx6qS+=XZ-hG86ttR8ZxFxeTzLw@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lennart,

I spent some time understanding the systemd-pcrlock and TPM stuff, and
got some idea about it. Could you correct me if I'm wrong? Please see
the following comments inlined.

On Mon, Aug 26, 2024 at 9:40=E2=80=AFPM Lennart Poettering <mzxreary@0point=
er.de> wrote:
>
> On Do, 22.08.24 22:29, Pingfan Liu (piliu@redhat.com) wrote:
>
> > > Hmm, I'd really think about this with some priority. The measurement
> > > stuff should not be an afterthought, it typically has major
> > > implications on how you design your transitions, because measurements
> > > of some component always need to happen *before* you pass control to
> > > it, otherwise they are pointless.
> > >
> >
> > At present, my emulator returns false to is_efi_secure_boot(), so
> > systemd-stub does not care about the measurement, and moves on.
> >
> > Could you enlighten me about how systemd utilizes the measurement? I
> > grepped 'TPM2_PCR_KERNEL_CONFIG', and saw the systemd-stub asks to
> > extend PCR. But where is the value checked? I guess the systemd will
> > hang if the check fails.
>
> systemd's "systemd-pcrlock" tool will look for measurements like that
> and generate disk encryption TPM policies from that.
>

Before kexec reboots to the new kernel
systemd-pcrlock can predict the expected PCR value and store it in the
file system.
One thing should be noticed is that PCR value can not be affected.

And kexec rebooting happens. systemd-stub extends the PCR value. When
the system is up, systemd checks the real PCR value against the
expected value rendered by systemd-pcrlock? If matching, all related
policies succeed.

Do I understand correctly?

Thanks,

Pingfan


