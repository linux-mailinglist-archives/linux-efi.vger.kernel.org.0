Return-Path: <linux-efi+bounces-657-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85E861A0D
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 18:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984D7288833
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2BE133991;
	Fri, 23 Feb 2024 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEP+tViy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2F1292DF;
	Fri, 23 Feb 2024 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709874; cv=none; b=k5kCVXKziWzHhPNtDPaGlEJGTI70rXUptCwls5FDmAAj3u7f/GMa02kjWsuTfxuA+AhM5CoVqei6g2PUHhQ0PMHffcFikH5UNe0U+2CEUd6h5QaaiQk69P5NEc2IZQI7xmsTqwz6jZFw81xvp9UAIqWg0cX9BNc+QrSNu4N2ru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709874; c=relaxed/simple;
	bh=+C0eEtfMj4S5hq66oGvN7X+C67tb5HSsGQI9RTl/0qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArOSPVkd/oJxGxoqEznvDrW9oxFoceSN7cAvqVJEIirEvnfZvav9xb4DTS2Yd1wOAPnBeaZqgfu8k2LmP6xl7c5OK42nxwHhqnA1owyQrDWgKPJrgadYEsFmKsXb3xs780FSkLqWyO9+W09rtYGx8tDHCtFaq7aVMuC7SyML+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEP+tViy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D08DC433B2;
	Fri, 23 Feb 2024 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708709874;
	bh=+C0eEtfMj4S5hq66oGvN7X+C67tb5HSsGQI9RTl/0qE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kEP+tViyvM7Lrh/MbLagrSkN+jODt1LddtU2XN9CKOxciJqDuUC+KWPx6HK1vQiRZ
	 Z03wfY2dGrmAOsOzrfqSV+ldO/4zJDXLem+Bw0LLaln80jKmoor8m7WzEt0gPMALkT
	 fpBNDYFsSzymBNoXa0Pshr8mWMAXD6eR8vA0I9UWI5WyAvcDd+voT1g3CIbupxMGi4
	 qbgbJFlfKhKBqdSFF1FS8JLCRNfkKGjW51U0A+6Ys0rL7XnvfL/Ru92pLiFUK6JVwx
	 Nr4wHmhGWVGplW4ner+JiGqFpk6q8b0ma/2/qFpvcvoP58Oh6yXIw74TUuya/+vley
	 ye9bJoWJ7wmuQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512db550e3fso1420350e87.2;
        Fri, 23 Feb 2024 09:37:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCa1k3NggxqnJlcRu/JpSehyiBK4/AGQrdCgPbn7CoZUyCENLogFqg7MUqfyFZxW4zoIk8igCQBY9gJkd8CvATAN7v5vW2ymCs7oL6pcKu2X/MdLgHD4woBhxZytEHe24hkFRqGQQyeaXN81No56IA4srH4rvqJf5MpMZDfsEawZN2ZKTPgnALwf6+D7d0GEHvS6ak3/tZpETqEkkGojQ=
X-Gm-Message-State: AOJu0YzTXfPnncck40FEape0q073QEHUEdY+hLBabMiBVg1+GsQcbtNa
	QX8F9zcpp1dFE6PTFPgIEc2ktICR3HQdHYc7UsmWm/bxpJtN7/rav33zq0doftGjd4/0YGyzGzR
	FiFEyoKKpuHlyom0P0T0S+ygjJw==
X-Google-Smtp-Source: AGHT+IGNZjMvh7S1025ZqB3yiouLwHO2vlT54KE7NgY7X2HF/zxZWnWrt4cVuNfv3VT4Hbk1i3E7ekmPzVTC0DOYjdo=
X-Received: by 2002:a05:6512:480c:b0:512:a04a:52d6 with SMTP id
 eo12-20020a056512480c00b00512a04a52d6mr270864lfb.44.1708709872305; Fri, 23
 Feb 2024 09:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
 <20240221233026.2915061-5-saravanak@google.com> <ZddNAHqwCNR5MZc4@smile.fi.intel.com>
 <CAGETcx8-fz7ijTJcBLMWetrZRfvS5GGGOBBoFM7an6qDtZ1NNg@mail.gmail.com>
In-Reply-To: <CAGETcx8-fz7ijTJcBLMWetrZRfvS5GGGOBBoFM7an6qDtZ1NNg@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 23 Feb 2024 10:37:39 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLZbCJ3ziFFtq9V30rvCw_Y+-XUCJNXeHeRA8u76LYQuw@mail.gmail.com>
Message-ID: <CAL_JsqLZbCJ3ziFFtq9V30rvCw_Y+-XUCJNXeHeRA8u76LYQuw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] of: property: fw_devlink: Add support for
 "post-init-providers" property
To: Saravana Kannan <saravanak@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:04=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Thu, Feb 22, 2024 at 5:32=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Feb 21, 2024 at 03:30:24PM -0800, Saravana Kannan wrote:
> > > Add support for this property so that dependency cycles can be broken=
 and
> > > fw_devlink can do better probe/suspend/resume ordering between device=
s in a
> > > dependency cycle.
> >
> > ...
> >
> > > -     fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_=
np), 0);
> > > +     fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_=
np),
> > > +                     flags);
> >
> > I would leave it one line despite being 83 characters long.
> >
> > ...
> >
> > > -                     of_link_to_phandle(con_dev_np, phandle);
> > > +                     of_link_to_phandle(con_dev_np, phandle,
> > > +                                        s->fwlink_flags);
> >
> > I would leave this on one line, it's only 81 characters.
>
> I don't have a strong opinion either way. If I need to send another
> revision out, I'll address this (if checkpatch doesn't complain).

My terminal is >80 chars, so 1 line is good.

Rob

