Return-Path: <linux-efi+bounces-428-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1583B3DA
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jan 2024 22:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E4CB23147
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jan 2024 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4C1353E4;
	Wed, 24 Jan 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/C7nsy2"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79E131757
	for <linux-efi@vger.kernel.org>; Wed, 24 Jan 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131540; cv=none; b=PLjTBuBR+hRkb19Uy06CJBxbz/zTTu0PgGb7hEzKiSCDYgZeSeZFaapLcI4ygdwYXVAYNgV5QRW9PAvlZ+DsTL/qesRPuEaFMoU3ngx1X9JGGNFzQN8owF/d67dkQ2A+oOPyYLdE6XyYaSoqeNyfIqA7VbLBZ5ynZ/SoHLuctko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131540; c=relaxed/simple;
	bh=41yr/k9pg0nXDa50lJm3KIxoZszGdUcvNpLuv1FNMxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=in9aMxtFWc86Lws6YOXyJHawEMfu29VTk22mRTByq/9R5VDFBkIuD/ep5v55I4fNkTnh1HY16htRcUC0eAaFrJRj0oUo7syORbju0vVpzEOB4x/QSMyyVYNDOu61lhBgIic0Ww+ySFdvjZEf4wgqyXRj0B0W1TKX9wrtAYrsuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/C7nsy2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706131538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsZGAZvBdhZK7fdXjVzGYu8HkXRsJN03PHr+uP2R2GM=;
	b=V/C7nsy2rVjbBENTdKhbMl4UO+3rHi7ouy5EGUtQSYPwbL06RhQyyRuSEXTfLFs8WMYoSd
	Sw/pVwC74qQr/eBZUfYqBiKECYC5mzDcf2FmaExB7ztMmSr9ldbeNyUbEE1/uD+6peoZ2r
	pX4sOQlg9P/Er0KQimE30LW7TnVvJgY=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-DRA46MH2NP6FyL88rnwzYA-1; Wed, 24 Jan 2024 16:25:36 -0500
X-MC-Unique: DRA46MH2NP6FyL88rnwzYA-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7d2dfa4c667so569008241.2
        for <linux-efi@vger.kernel.org>; Wed, 24 Jan 2024 13:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706131535; x=1706736335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsZGAZvBdhZK7fdXjVzGYu8HkXRsJN03PHr+uP2R2GM=;
        b=lx3/h8bQQgsspBc+5T3JvTsVIHaot1fso787jHoPo1giVhoPrUrwJ1etA9zR+HX2Rs
         er4nP3eHj4Fu1iX0ucnvozF4Vz9+EO5mRapCiRqqMoGNJZSpbktEKgtVi70I3Azt9g1H
         tyFvDP99ABLNKwVeD/Pq8H/czctrHPx8zUvmuEXIkVEufvZA58x0CNnHN56+hoHA8W21
         ZYWW1Nz6s4yp1gHxObhu3uJ7QmhdM/ys6uR6dN4Pr/3c4aTCUIBpbXGK8Um/t4ClA/93
         Xyza310oe3OmrLka4dCzEWKQl95AlIpXkNaEFP4lQgtYsLBODQ+e29iLzSmoiQgR1Ay7
         KC9Q==
X-Gm-Message-State: AOJu0Ywv+mu6ZaBJlHiW8QdSTRsG885C2a+e9Z4acyCtptcJ8Q7ccSYd
	coTbLtCIg3NI8HPS9yQmARniNdxBa1GBmWTPAnYILv7G9IUcsBd6VBKpGRgcnt1G9MG54RYy9DM
	pFoq3FhL3/4AW9f3iNPh5xk7unshakQBjxllQoBQJqPCpLPKiddf24R+ndymmYm5exuNaPh5qNM
	/YnK2ljwNfjpoIWMFlzHQuXD6hYZVO/tITIgpWjZYn
X-Received: by 2002:a05:6102:3214:b0:46a:fc04:53ea with SMTP id r20-20020a056102321400b0046afc0453eamr28311vsf.3.1706131535600;
        Wed, 24 Jan 2024 13:25:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq1ByprCP/A0i5Yz3VCDF5P4Zz+Tk86Ju97ahmxF9yt3vgZYZAHX7wEgWPN68BT8aAbgU9AomLahqu+Ay58d8=
X-Received: by 2002:a05:6102:3214:b0:46a:fc04:53ea with SMTP id
 r20-20020a056102321400b0046afc0453eamr28304vsf.3.1706131535251; Wed, 24 Jan
 2024 13:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122231507.1307793-1-timschumi@gmx.de> <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
 <223a4e75-2e06-4bc6-a70c-823f0eb308d7@gmx.de> <CAMj1kXEKF_a6wLtoMYCwBKEVDo6k1u=Cas-=4Ar4WnANHNu+cg@mail.gmail.com>
 <b58a112f-767f-4918-8262-63ac1dbfebbf@gmx.de>
In-Reply-To: <b58a112f-767f-4918-8262-63ac1dbfebbf@gmx.de>
From: Peter Jones <pjones@redhat.com>
Date: Wed, 24 Jan 2024 16:25:24 -0500
Message-ID: <CA+g+hrh_REk-bcTt-D+eSngofxdejeRXuXKhf1O15wzn+qMy6Q@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Iterate variables with increasing name buffer sizes
To: Tim Schumacher <timschumi@gmx.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:33=E2=80=AFPM Tim Schumacher <timschumi@gmx.de> =
wrote:
>
> On 23.01.24 15:09, Ard Biesheuvel wrote:
> > On Tue, 23 Jan 2024 at 14:55, Tim Schumacher <timschumi@gmx.de> wrote:
> >>
> >> I'd rather avoid introducing deviations from the specifications on the
> >> kernel side as well.
> >
> > Which specification would this deviate from?
>
> The preexisting comment claims "Per EFI spec", and it appears that I got
> mislead by that. Neither the UEFI specification, nor the newest revision
> of the EFI specification (which I guess is what would have been current
> back in 2004, when this comment was introduced) seem to make any mention
> of a maximum length for the variable name.

Curiously, I can't find it in the 1.02 spec (the oldest I can find)
either.  When I inherited efibootmgr around 2013, this was a
limitation there, but I don't see anything in that tree that claims
it's a spec limitation either.  My suspicion is this is a former
Itanium firmware limit that got promoted to "the spec says" by word of
mouth, or was in some very early ia64 implementation spec.

-- Peter


