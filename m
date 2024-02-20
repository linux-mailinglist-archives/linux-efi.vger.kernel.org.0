Return-Path: <linux-efi+bounces-594-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F325B85B7F5
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 10:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CE4281162
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D751E6026B;
	Tue, 20 Feb 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Leozg8Iv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E055FDD3
	for <linux-efi@vger.kernel.org>; Tue, 20 Feb 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422109; cv=none; b=kRU8SY4f7Duo5ACJ01Er9tX/z0FXpqzhvISKtNoOSPdLcEGSMBhEX2+Ed61VuHrjnwb0dwXBWvX218LHlcdj09cDxvbmQwCPGUiHqQsI1fFewzXpcFiVSxM2QZE8smAHwZM3pZSuagIl546TketYq7XWzzJRncjBHzqlWjady1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422109; c=relaxed/simple;
	bh=UPcLKjHlyC38Lt5s8TPhv+qOJo45oOSFr2wIKDQGaE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTrxUvzXmbngqlpOXKyjEhO3jPWjywAnKg43E+SQ6e4W4QrCWj08H5T+RFbPuLSFQ0We8XD5kRoJq8KN49ws52wY7YhqLDAB32z/noTSoRoGE97Q3G9LRO/3slQOsl8dXj9EOv6Ib/qzdLMKjyFbA9yHaw0UQ52OSUK7/zLz2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Leozg8Iv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B31133F17F
	for <linux-efi@vger.kernel.org>; Tue, 20 Feb 2024 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708422104;
	bh=fTPqNxuhHfpwk/b7ZgI9H1VgQ95qQ0tlqSbUZkwFr5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Leozg8IvxIqewLwkyd/AIDNVBhGBkWMVMO5L+2294n3nvUAkU+7v7bsmaykYgjM2f
	 4qXXlzDvbDJO6cPtEJqtQ0yXJztpoQRjJkbZASNMNB/PlHkNlMHIxSDE8QqlU15V4w
	 Du7gQ4KnxNb7dJWl/98SrRtf7X5iUF25AMOlKOLohiTndhtd0s64RnfZQUXa+gPoo/
	 H2yqcEJ98uHvccOFcniTz45ggkW+6T9rISng5mceP0G+M9yACSSwX1LzA7g43mSqic
	 XLQhgOvOGvtS2sgKwP1eDMmRAH7xSMRVF9KMHq3UZsYSDsWNHdfPK8pTm/O28qnlq2
	 oKOS1ZqtQlafw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d308b0c76so1165407f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 20 Feb 2024 01:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422104; x=1709026904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTPqNxuhHfpwk/b7ZgI9H1VgQ95qQ0tlqSbUZkwFr5U=;
        b=bqiSppa/OW3WUQ08tasJv9Juk+4vSubu1lxeQ0DR07V+GE+fWJ+bpRRWSpfDYlltYF
         XGyr7uZuJT3FTlvWgE+UQddv5qHHyyoB+HmnY3vmUpF+FuvtZkXOeD3q6jSUIriIXTeh
         cTN3I3p4r0MZtqUFcWdL1v/mzhPWGoeycmvErzydZnCJWj/EjolfdpDBdUYS+1t/iI5s
         wWs1qRlPCZh4kOQXjcgLbuHnbCASnmTGNkmUXDl5MNQjWrzpSOlX0agftAogeSiO0aOP
         t3HAG1bPuJNIeRYm4ahAz3zfHtFjB5Gd8l2oS3eiSqNiXvohRtmWr+LFW89MFJ0S8wHW
         /6wg==
X-Forwarded-Encrypted: i=1; AJvYcCUJhNIG+/qir3mEvOXW/h73icBBFerGTSVAONZRTJD8BPfZOij4xUQmWqcA7c9jIf5N7E9guAslvCtCRiIROvhm9JvjGK4ChB87
X-Gm-Message-State: AOJu0YxYBqtib7lS3XijaKmWIPmPL7PT1RMKmGpyq8jRq3VAiSqQ83lb
	/fx39hUwm16l+GiBIdaU3YekcYIP2mq6elR7+BjujygQZo7x/QBZ0lu+240hrjJZ43QnHVgFZxc
	bzK8ASeK+IuC4sLPsLv3NOPDTxuUwUkVrVgKKwqUTJDfvioILjfjoqvCRX8Ihr4oQ2fNmMLrHr9
	/T///f3ugGa2kVNm2X/Vbq0sv9WnW5zj9h7xuLur9Ti2PpIVGO
X-Received: by 2002:a5d:5345:0:b0:33d:1bd1:8ae2 with SMTP id t5-20020a5d5345000000b0033d1bd18ae2mr9576715wrv.19.1708422104449;
        Tue, 20 Feb 2024 01:41:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEStYiQMGNGaBe/24htrF/Ch7IUVdqtRIbtGHrvc+8LpF5F3cNV0bFFeOXu6KrMg+A2nJnnRGsfFC4tMbCUwHw=
X-Received: by 2002:a5d:5345:0:b0:33d:1bd1:8ae2 with SMTP id
 t5-20020a5d5345000000b0033d1bd18ae2mr9576697wrv.19.1708422104136; Tue, 20 Feb
 2024 01:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXG4HpAHYKwz27_Qy9_Wx+O_QJDmA4CBXcMrvVcrOXhBxw@mail.gmail.com>
 <87plwsj6ar.fsf@xnox-Inspiron-7400.mail-host-address-is-not-set> <CAMj1kXGjxtMnJ6MeeE-W73Jw_seRPnQwVDRyBayDzKvaDLFLjw@mail.gmail.com>
In-Reply-To: <CAMj1kXGjxtMnJ6MeeE-W73Jw_seRPnQwVDRyBayDzKvaDLFLjw@mail.gmail.com>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Tue, 20 Feb 2024 09:41:08 +0000
Message-ID: <CADWks+YuLjPA++8EfPa=7JM6DMO2wErF3DOkYCkY=9JKujpKeA@mail.gmail.com>
Subject: Re: x86 efistub stable backports for v6.6
To: Ard Biesheuvel <ardb@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	linux-efi@vger.kernel.org, jan.setjeeilers@oracle.com, pjones@redhat.com, 
	steve@einval.com, julian.klode@canonical.com, bluca@debian.org, 
	jejb@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 08:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 20 Feb 2024 at 02:03, xnox <dimitri.ledkov@canonical.com> wrote:
> >
> > Ard Biesheuvel <ardb@kernel.org> writes:
> >
> > > On Thu, 15 Feb 2024 at 12:12, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> On Thu, Feb 15, 2024 at 10:41:57AM +0100, Ard Biesheuvel wrote:
> > >> > On Thu, 15 Feb 2024 at 10:27, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >> > >
> > >> > > On Thu, Feb 15, 2024 at 10:17:20AM +0100, Ard Biesheuvel wrote:
> > >> > > > (cc stakeholders from various distros - apologies if I missed anyone)
> > >> > > >
> > >> > > > Please consider the patches below for backporting to the linux-6.6.y
> > >> > > > stable tree.
> > >> > > >
> > >> > > > These are prerequisites for building a signed x86 efistub kernel image
> > >> > > > that complies with the tightened UEFI boot requirements imposed by
> > >> > > > MicroSoft, and this is the condition under which it is willing to sign
> > >> > > > future Linux secure boot shim builds with its 3rd party CA
> > >> > > > certificate. (Such builds must enforce a strict separation between
> > >> > > > executable and writable code, among other things)
> > >> > > >
> > > ...
> > >> > > And is this not an issue for 6.1.y as well?
> > >> > >
> > >> >
> > >> > It is, but there are many more changes that would need to go into v6.1:
> > >> >
> ...
> > >> >  32 files changed, 1204 insertions(+), 1448 deletions(-)
> > >> >
> > > ...
> > >> > If you're happy to take these too, I can give you the proper list, but
> > >> > perhaps we should deal with v6.6 first?
> > >>
> > >> Yeah, let's deal with 6.6 first :)
> > >>
> > >> What distros are going to need/want this for 6.1.y?  Will normal users
> > >> care as this is only for a new requirement by Microsoft, not for older
> > >> releases, right?
> > >>
> > >
> > > I will let the distro folks on cc answer this one.
> >
> > Canonical will want to backport this at least as far back as v4.15 for
> > Ubuntu and Ubuntu Pro. So yeah, as far back as possible will be
> > apperiated by everybody involved. Since if/when firmware (VMs or
> > Hardware) starts to require NX compat, it will be desired to have all
> > stable supported kernels with this support built-in.
> >
>
> Thanks for the data point, and good luck with backporting this to
> v4.15 or earlier. If it helps, I have a branch that backports
> LoadFile2 initrd loading support to v5.4 (below), which you will need
> to backport first. Going further back than v5.4 is going to be very
> messy IMHO.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-lf2-backport-x86

Yeah, we are not yet sure how far back we will actually manage to get
to. And things will need to move one series/generation at the time. As
other pieces need to land too.
And yes, the above repo is helpful.

-- 
Dimitri

Sent from Ubuntu Pro
https://ubuntu.com/pro

