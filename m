Return-Path: <linux-efi+bounces-675-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C8B86D158
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 19:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89671C2237B
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846478271;
	Thu, 29 Feb 2024 18:01:53 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3C2E410;
	Thu, 29 Feb 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229713; cv=none; b=hIZya39f9v2mIRmXB/NQd7BxvRAgYgKnY8FobrlUf6ykaWykOUJ7R+vuko9H+8hyLj4YMH/5A+pl7b59Fsh6qNecdlDzMyV/RpAcKf0eTYflAEnAxKvYmkaBKjQmz3YouIrohR3Hun4uuMEenyxyfJeN1sOJj6J7bFhCc99IgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229713; c=relaxed/simple;
	bh=5gFW+EkEscuc84mlRSPQOlQC1BaAKNWbJPEDvF+/4tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoWzzGE95fgram9XJqRgGi9z0tdbqBgs/R9fj4ir06G4rIUEeKLbpr/xeXaS6cTg/QcjHWyIgzC5TKc7M5V7i6t7ZoeDiU6+NPtudE2ahaNwT+skfLPFOIL/eMt6uMf9aCqNNyg1+tv3KfHaQQyQLXIkSIYeT6Nue0h69dpnVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e4aa4877a9so105490a34.0;
        Thu, 29 Feb 2024 10:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709229710; x=1709834510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gFW+EkEscuc84mlRSPQOlQC1BaAKNWbJPEDvF+/4tM=;
        b=TvvY4Sb4+I6HbgKZkauJWZv0+AP+IK6FZYdoORmCINfQu47Va5lZGIgQ0YVFI9YndA
         T9jQt+irKin/n9cNNSQdHmfGXXXPgc42pKG57wx8k7EQMJ9fZVV4SBKPYxxv9yEpUEQS
         cMWtk71lPiIiUNbEwoWYdU6AS8urVpK/a77XLQGi9EHkD7D9LWorqCLlQVTW3jewG2WG
         ecaDBUHUVJ2QYqdUULrUnpOiuNv0i0XqD3DpHTjEZAJJTn9v++npo/x05QE+TT4zJ1ZJ
         iM3ZyI/WLsv3f8uP3ekCdfzH2CrAq/pp/FuF42Y90T67cDev5hsCAu3UE8lWqQufmd0J
         wMKw==
X-Forwarded-Encrypted: i=1; AJvYcCVT/JfuH9ugSwkqV9kRWA1QrUqq7h7VUZZrBRgxUq6rYgT1pXCxPohuGVwthwL1UAqrvRQDYXQmIjoi4N7i5vfMQGR6F7b37MLJ/T4TG+5zQn4Mzrfdb0W6CSQT1maFrPeHFokGefyRkUFrB4W+NdJX7NbowyZYm19Kne+tC0JmQBItoeT0Edih2oZLoR3WifCdo1mlKrxWsR8vTnLDheU=
X-Gm-Message-State: AOJu0Yz30MUAmjTzaKbXng5mp46UNrM4isuOU4qmpEduj+L5KSCi/I55
	pXEJleK+K5eM5C9nPtxvHih8ZzITSPqucMt39qhD25mPXdwILrVyeibemJ1126KE9uZug/F/ppv
	+pncE3oH2cTxDeU5JLNMMe/7aQvI=
X-Google-Smtp-Source: AGHT+IFpH69RIGrQwoxFmXil0qhXUtU6OBzg1/87HwfqwpAs8vQ0VMCBcXGgjIvLqp1q9ciYe0BH3pc299uW9NfLPGA=
X-Received: by 2002:a4a:301:0:b0:5a0:396d:2489 with SMTP id
 1-20020a4a0301000000b005a0396d2489mr2765066ooi.1.1709229709567; Thu, 29 Feb
 2024 10:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
 <ZddNdqoqEz3BSXGI@smile.fi.intel.com> <CAGETcx_usPewYSPq=E_-_fuSge7H+YiQwS8Z4bbouX0SSH6sOg@mail.gmail.com>
In-Reply-To: <CAGETcx_usPewYSPq=E_-_fuSge7H+YiQwS8Z4bbouX0SSH6sOg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 19:01:38 +0100
Message-ID: <CAJZ5v0jYTrHiqwPxAQg8mJpWKBgp8DKjGQ1Vucfy3R0LKeLjGQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add post-init-providers binding to improve
 suspend/resume stability
To: Saravana Kannan <saravanak@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 1:03=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Thu, Feb 22, 2024 at 5:34=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Feb 21, 2024 at 03:30:20PM -0800, Saravana Kannan wrote:
> > > This patch series adds a "post-init-providers" device tree binding th=
at
> > > can be used to break dependency cycles in device tree and enforce a m=
ore
> > > determinstic probe/suspend/resume order. This will also improve the
> > > stability of global async probing and async suspend/resume and allow =
us
> > > to enable them more easily. Yet another step away from playing initca=
ll
> > > chicken with probing and step towards fully async probing and
> > > suspend/resume.
> >
> > Do you know what is the state of affairs in ACPI? Is there any (similar=
)
> > issue even possible?
>
> I'm not very familiar with ACPI, but I wouldn't be surprised if ACPI
> devices have cyclic dependencies. But then ACPI on a PC doesn't
> typically have as many devices/drivers and ACPI might be hiding the
> dependencies from the kernel. So maybe the possibility of a cycle
> visible to the kernel might be low.
>
> I would really like to see fw_devlink extended to ACPI (it's written
> in a way to make that possible), but don't have enough knowledge to do
> it.

This might happen one day, for example in the _DEP handling context
(for now it is very limited, but I'm not actually sure how much more
capable it needs to be).

I don't think that ACPI will ever need device links between parents
and children, though.

On a related note, RISC-V people seem to want to use it on ACPI
systems for interrupt controller dependency tracking.

