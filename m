Return-Path: <linux-efi+bounces-635-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263085F001
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 04:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8539F1F256BA
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 03:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9F21799C;
	Thu, 22 Feb 2024 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGsjpPZ8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10201757B
	for <linux-efi@vger.kernel.org>; Thu, 22 Feb 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573317; cv=none; b=IFttSa57xiecxDmaHteBNDMbSpyeH5Uf9z7K5FB1aNemDTirbXRAa4lwNDWDKogTYeKcVDCgIslkT2J4EJY3P4OgnPmB5oHFFgT0Wegwu0UDT5RfeBor0gGJUg6j39jduLeYfc/g0ykkYU/ShwWuQ5IhOhzNEe6t9uoEguLI+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573317; c=relaxed/simple;
	bh=CFleHBNrQpRDBWB+bPrY3lACjfd7SpfoVKRa4Rm7usE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0Yfvr9/Yixoi1ah7x8pY3pGIMraUA9p8u87GBPykiiw4ysit5pq+KfA6Z9J7wjEEtPoJeYSOgbTtliXAnpBgpJcoiqFFi0+8LZKeLQEEp9IqN/kNFxCI4JG8a2tUz9f7VoyBPK9H5D//GrzWORWy1TYBdqqTZriQhuH4WakrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGsjpPZ8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42db1baff53so98721cf.0
        for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 19:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708573313; x=1709178113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkWn2p2KoktTF74iyosyAqtgPvGQax193IdDSSf0wdk=;
        b=RGsjpPZ8fpxN3eTzLGz1eZxxOFjwO+7HrSuwUmiE71lFb5IKrVyulevIhya7ZmALez
         jy3xk7BjCpG+f4jVyAE+HC+lKJkomau5gSM9vbveLWZ1M7Z8R8BrVC8f8suFidwPwR5/
         ykd3fNXw5Yd+rQxp0dcNmjgxxeeJN9oZP7cXrP9j3NJOoN2lN5H4yTsluwawdw9Rm+zJ
         GXPa0qDPtDVGyDUO7x7R+Kt2qFQ0VE69V64RNtiHnyMgn29ob7gN9uBlqTAWzhe1GAue
         6cMzqGkOVyEgBzIyC91gL8Fjl27zIXLb7mb4l+4dqYdDpT5qPYnoLy4dWw75H1bp9uV5
         p+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708573313; x=1709178113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkWn2p2KoktTF74iyosyAqtgPvGQax193IdDSSf0wdk=;
        b=nnQXGhCa5WwC4XQFI/aie7aT9BELzwWFpVIPUFnmJlMpE5Bq8orpiEzpYFp79UXpNP
         oDGqshhMN+DDGsJXnSapbBkKvwn2joL0kV3ESUwTK/t08dyjAvbJsZb8C5wl9//xygrz
         3MluAmmZy47cPQdJAftEGK3/7IyJHqcBvKgXcauOZJCAt2ubKzH3yplw6RYl4Qelqcnk
         czxxow78odpR2GhZ5S8x/WbF+kMzv/oM9Upj9dpC8fia3D/l5v1jq8H2ZroEk/N7DRy6
         q1BnsT8AzTKaMB/r/iVNDan5ffjFt1GBBrE9AxhXlcphhsw4TRNP+JNWRP83fvqgf8D8
         oGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcbAZUxhhT8XfCciTyFUJT/SL6gH7LsRE5QfoXKt+MZrjju4jlscK/aJcI8pW/aGXJ8GJGAr/R3beb7yMafAncKHaQDdvnRkKj
X-Gm-Message-State: AOJu0YynxZPlPdYxbCCl6jDYCO2HoVdrAlZEYNR56VlE6Cf1rJSA4Eiw
	wwyjiNGOHYxFSAuvvRsqbFVnhAsbHWWY++/0X+9iDTvIROkRp3251hbhUnHrnP/NEPlI6K3bO4P
	Q22RntRDd4Uu7svor0HCOgE+DNnqsPbEvsSxN
X-Google-Smtp-Source: AGHT+IGvjS/JsDjKLRtFXUpHvTnqcMileQ3GCikt+aLAGrSc25d+ufjOgPr0Fh2MCXQbYqWszHyGfO3vfuuMY/hfPQk=
X-Received: by 2002:a05:622a:68c9:b0:42d:be0f:e30a with SMTP id
 ic9-20020a05622a68c900b0042dbe0fe30amr384702qtb.23.1708573313369; Wed, 21 Feb
 2024 19:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
 <20240221233026.2915061-4-saravanak@google.com> <170856138383.540970.12743608676098316685.robh@kernel.org>
In-Reply-To: <170856138383.540970.12743608676098316685.robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 21 Feb 2024 19:41:16 -0800
Message-ID: <CAGETcx9v_NHhC4EwKDQ1UQMQQB=B2e1nQSqJZAwc7VwEWztp8g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: Add post-init-providers property
To: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	kernel-team@android.com, linux-efi@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-acpi@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:23=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Wed, 21 Feb 2024 15:30:23 -0800, Saravana Kannan wrote:
> > The post-init-providers property can be used to break a dependency cycl=
e by
> > marking some provider(s) as a post device initialization provider(s). T=
his
> > allows an OS to do a better job at ordering initialization and
> > suspend/resume of the devices in a dependency cycle.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../bindings/post-init-providers.yaml         | 105 ++++++++++++++++++
> >  MAINTAINERS                                   |  13 ++-
> >  2 files changed, 112 insertions(+), 6 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/post-init-provide=
rs.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/post-init-providers.example.dtb: /examp=
le-0/clock-controller@1000: failed to match any schema with compatible: ['v=
endor,soc4-gcc', 'vendor,soc1-gcc']
> Documentation/devicetree/bindings/post-init-providers.example.dtb: /examp=
le-0/clock-controller@1000: failed to match any schema with compatible: ['v=
endor,soc4-gcc', 'vendor,soc1-gcc']
> Documentation/devicetree/bindings/post-init-providers.example.dtb: /examp=
le-0/clock-controller@2000: failed to match any schema with compatible: ['v=
endor,soc4-dispcc', 'vendor,soc1-dispcc']
> Documentation/devicetree/bindings/post-init-providers.example.dtb: /examp=
le-0/clock-controller@2000: failed to match any schema with compatible: ['v=
endor,soc4-dispcc', 'vendor,soc1-dispcc']

I'm assuming it's okay to ignore these warnings about made up
compatible string names.

> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/=
devicetree/bindings/post-init-supplier.yaml
> MAINTAINERS: Documentation/devicetree/bindings/post-init-supplier.yaml

Will fix this and send out v4. Ignore the v3 series please.

-Saravana

>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202402=
21233026.2915061-4-saravanak@google.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

