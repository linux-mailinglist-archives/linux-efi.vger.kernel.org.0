Return-Path: <linux-efi+bounces-674-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE786D142
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 18:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C511C220A8
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BE78297;
	Thu, 29 Feb 2024 17:57:24 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4F7828C;
	Thu, 29 Feb 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229444; cv=none; b=Czo0EuZ7qyj0xZoWKY+KRrQl4J11UJWP8TW6WlWwN3xfKXsyJ/K5W0r+BZodoAcbcPLG5AEL/y7EmcY23KzvSkxqzYkijZndk3+NrnlfBw9oadYE16bllPN58dOJEYOoDSuFb3mVmdfCMdhGhFcOyrtUuTzoXVGz5q62W6y6m50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229444; c=relaxed/simple;
	bh=UuJ5R6UHtUuHtpxbX7C/d/Kenv1ttNDw/V2vJu2uQCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvkQe5jcceU+qUpGYiKPmNRyHoUiE4KoKuFJ9JjZ3ewPQn5PkboUpNriZ8zoqnDFxAZXDYLwfHBccj7n0pY1tPK8fpPiUVUI4dWoVzZ5Rtz8J574+18P9VSu0Vy67Y9VhBPWynt4mhsN/uVRMJzYr2KC8o2kvBSwQQg162NwEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e4abd673b3so324794a34.1;
        Thu, 29 Feb 2024 09:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709229442; x=1709834242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJTPU54UfJ93SuYm6+FCcJPuAqSAKr+TdhLWaY0gCS8=;
        b=AjEKOHPzAW+oWRH9HzjQUtHSUMCgkEPDQhLErrCej5jTcElO+dNkHBe1jp7NkjtR6T
         0zO+LGNla3eaoG/j3X2dXqa0QmeY5VDaEICPlh39VWrGY0B0qUKR6h/fCcvSiZfVIpdo
         +DwomqR/ZQFkQthsndDaZjstaeGxAa1GZf+d6z5RlPfOMMdux5areSdFeHh33QFhPGr/
         sg0F9zdbjoN+GMNTtgkk7xztcBiQ0eb9VOtV4lnI3q6IoesNtS7iWYw5mnvCmzpKmejQ
         6yhTuzjWkgyvVECjbXcrhmhqVPkvQDfK1DZc4onss82uuSEsX3EuszO5gNklWhvUVws4
         wYKg==
X-Forwarded-Encrypted: i=1; AJvYcCWauR2rNg8J4cZu1x/PvaYwoCtNxgB+a2XTf5gTVh3dkTCZ0FTSQxvBEqNMU1WqByPDwnBTF6bG1YJOWwFnNt+Nq9Y8hDBzYho+MBKjj2a/+jU57sqEuVOReMov4DSp/pb5T47wX8ud9VTNUspsBcBNF8WmEu2ZwKge3l/581xmHukR831rD3CEyJAKG0QxyQucweSUSbVB84EZmalTXF4=
X-Gm-Message-State: AOJu0YyxCvkHxcumHqp6FHX7AizEk58jYSQzAgIgHEdSX48tYeCzL6dg
	jjinfDelCbuBUIN4HnlEnHDSCDEhw0EHq2ZmExuIwQ+xAj06Nw/pg9JnAaVGmTNaLn1CBzURSHe
	A30S4JwALMa+3grpjNGYl8V1U6WQ=
X-Google-Smtp-Source: AGHT+IHbt/7GHpSfnk8Q/5QSANcl5YF57K2GGbrrnozE+9Sir3uJwuEaxF1g/srdfDxTCVmvgx8Mi9WLYREdC4D883w=
X-Received: by 2002:a4a:d317:0:b0:5a0:2cbe:43dd with SMTP id
 g23-20020a4ad317000000b005a02cbe43ddmr2855890oos.1.1709229442327; Thu, 29 Feb
 2024 09:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222034624.2970024-1-saravanak@google.com>
In-Reply-To: <20240222034624.2970024-1-saravanak@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 18:57:11 +0100
Message-ID: <CAJZ5v0i4NtjW_6a5d9r7gRrtaUR-OM8U5UKKai8fm5v+PaXW1Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add post-init-providers binding to improve
 suspend/resume stability
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:46=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> This patch series adds a "post-init-providers" device tree binding that
> can be used to break dependency cycles in device tree and enforce a more
> determinstic probe/suspend/resume order. This will also improve the
> stability of global async probing and async suspend/resume and allow us
> to enable them more easily. Yet another step away from playing initcall
> chicken with probing and step towards fully async probing and
> suspend/resume.
>
> Patch 3 (the binding documentation) provides a lot more details and
> examples.
>
> v3->v4:
> - Fixed MAINTAINERS file to go with the file rename.
>
> v2->v3:
> - Changes doc/code from "post-init-supplier" to "post-init-providers"
> - Fixed some wording that was ambiguous for Conor.
> - Fixed indentation, additionalProperies and white space issues in the
>   yaml syntax.
> - Fixed syntax errors in the example.
>
> v1->v2:
> - Addressed Documentation/commit text errors pointed out by Rob
> - Reordered MAINTAINERS chunk as pointed out by Krzysztof
>
> Saravana Kannan (4):
>   driver core: Adds flags param to fwnode_link_add()
>   driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
>   dt-bindings: Add post-init-providers property
>   of: property: fw_devlink: Add support for "post-init-providers"
>     property
>
>  .../bindings/post-init-providers.yaml         | 105 ++++++++++++++++++
>  MAINTAINERS                                   |  13 ++-
>  drivers/base/core.c                           |  14 ++-
>  drivers/firmware/efi/sysfb_efi.c              |   2 +-
>  drivers/of/property.c                         |  17 ++-
>  include/linux/fwnode.h                        |   5 +-
>  6 files changed, 142 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/post-init-providers=
.yaml
>
> --

This looks reasonable to me overall, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

