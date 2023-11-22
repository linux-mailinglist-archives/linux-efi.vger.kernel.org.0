Return-Path: <linux-efi+bounces-79-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018577F452F
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 12:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952ADB20F2E
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021284AF93;
	Wed, 22 Nov 2023 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87591;
	Wed, 22 Nov 2023 03:55:51 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d7e89d48efso185584a34.1;
        Wed, 22 Nov 2023 03:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700654150; x=1701258950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnzgeFjuBItEyIVZYQBtxAG5TnFPC1Nz+dshenAaKC4=;
        b=lzt82JqMXjDrjKJqHRcWEA/7DdYOKdCXfv0OjcAjDCUtyn8f46u/eWRV60hAIwjiWG
         /nrhSAz8uO1D5UjpYAGUeT2+uJzkORhbjr+nItSuOWLD5Y2TGrEyaD01ho0ytOPweSkP
         ICtSwB+wetkNHSk90lPb6DmC43BaOVClPHHtQf9hDZ6gHqE5ybP4ziSwSBAszRKhSwnU
         iIZyNxeQFl6bzMAdWrfJNYPakW/d5IrowTHv14o5JZwZq1RpT6WXPWBNMNPuPFehvhXj
         VCp/ovpyUodYf9yxr9DYK/cDBZ346SUJ04QpB4OGmkT1Zf5WCuyggt2WbL+JhEBUD0Ec
         Z+UA==
X-Gm-Message-State: AOJu0YyTItu35it00JXMIxLLi35OvFJu8qFYWQKurg2/B1siWKEtLXbm
	0aExfWNgqrE4MN7Rybx1omCzK3YV3pbAM/MgNso=
X-Google-Smtp-Source: AGHT+IFxwoExJhSMBRxQTHXgD/nLHO3yL8dtRUR3JO04lud2KKUHrAdJ364xYPIIbgEneIKFFci7Dqs2zGd+NVIwZF0=
X-Received: by 2002:a05:6870:a924:b0:1f4:d544:2490 with SMTP id
 eq36-20020a056870a92400b001f4d5442490mr2623563oab.4.1700654150597; Wed, 22
 Nov 2023 03:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121103829.10027-1-raag.jadav@intel.com> <20231121103829.10027-3-raag.jadav@intel.com>
 <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com> <ZV2KYqah4FHH4tnz@black.fi.intel.com>
In-Reply-To: <ZV2KYqah4FHH4tnz@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 12:55:39 +0100
Message-ID: <CAJZ5v0gyuk-1vfpaRWO1wniYHwMp==Nx9KLVS42=39yXmqKq6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, lenb@kernel.org, robert.moore@intel.com, 
	ardb@kernel.org, will@kernel.org, mark.rutland@arm.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, mallikarjunappa.sangannavar@intel.com, 
	bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:58=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Tue, Nov 21, 2023 at 08:25:20PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 21, 2023 at 11:38=E2=80=AFAM Raag Jadav <raag.jadav@intel.c=
om> wrote:
> > >
> > > According to ACPI specification, a _UID object can evaluate to either
> > > a numeric value or a string. Update acpi_dev_uid_match() helper to
> > > support _UID matching for both integer and string types.
> > >
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > You need to be careful with using this.  There are some things below
> > that go beyond what I have suggested.
>
> I think we all suggested some bits and pieces so I included everyone.
> We can drop if there are any objections.

There are, from me and from Andy.

[cut]

> > Up to this point it is all fine IMV.
> >
> > > +/**
> > > + * acpi_dev_uid_match - Match device by supplied UID
> > > + * @adev: ACPI device to match.
> > > + * @uid2: Unique ID of the device.
> > > + *
> > > + * Matches UID in @adev with given @uid2.
> > > + *
> > > + * Returns: %true if matches, %false otherwise.
> > > + */
> > > +
> > > +/* Treat uid as a string for array and pointer types, treat as an in=
teger otherwise */
> > > +#define get_uid_type(x) \
> > > +       (__builtin_choose_expr(is_array_or_pointer_type(x), (const ch=
ar *)0, (u64)0))
> >
> > But I wouldn't use the above.
> >
> > It is far more elaborate than needed for this use case and may not
> > actually work as expected.  For instance, why would a pointer to a
> > random struct type be a good candidate for a string?
>
> Such case will not compile, since its data type will not match with
> acpi_str_uid_match() prototype. The compiler does a very good job of
> qualifing only the compatible string types here, which is exactly what
> we want.
>
> error: passing argument 2 of 'acpi_str_uid_match' from incompatible point=
er type [-Werror=3Dincompatible-pointer-types]
>     if (acpi_dev_uid_match(adev, adev)) {
>                                  ^
> ./include/acpi/acpi_bus.h:870:20: note: expected 'const char *' but argum=
ent is of type 'struct acpi_device *'
>  static inline bool acpi_str_uid_match(struct acpi_device *adev, const ch=
ar *uid2)

You are right, it won't compile, but that's not my point.  Why would
it be matched with acpi_str_uid_match() in the first place?

> > > +
> > > +#define acpi_dev_uid_match(adev, uid2)                         \
> > > +       _Generic(get_uid_type(uid2),                            \
> > > +                const char *: acpi_str_uid_match,              \
> > > +                u64: acpi_int_uid_match)(adev, uid2)
> > > +
> >
> > Personally, I would just do something like the following
> >
> > #define acpi_dev_uid_match(adev, uid2) \
> >         _Generic((uid2), \
> >                 const char *: acpi_str_uid_match, \
> >                 char *: acpi_str_uid_match, \
> >                 const void *: acpi_str_uid_match, \
> >                 void *: acpi_str_uid_match, \
> >                 default: acpi_int_uid_match)(adev, uid2)
> >
> > which doesn't require compiler.h to be fiddled with and is rather
> > straightforward to follow.
> >
> > If I'm to apply the patches, this is about the level of complexity you
> > need to target.
>
> Understood, however this will limit the type support to only a handful
> of types,

Indeed.

> and will not satisfy a few of the existing users, which, for
> example are passing signed or unsigned pointer or an array of u8.

Fair enough, so those types would need to be added to the list.

> Listing every possible type manually for _Generic() looks a bit verbose
> for something that can be simply achieved by __builtin functions in my
> opinion.

But then you don't even need _Generic(), do you?

Wouldn't something like the below work?

#define acpi_dev_uid_match(adev, uid2) \
        (__builtin_choose_expr(is_array_or_pointer_type((uid2)),acpi_str_ui=
d_match(adev,
uid2), acpi_int_uid_match(adev, uid2))

In any case, I'm not particularly convinced about the
is_array_or_pointer_type() thing and so I'm not going to apply the
series as is.

