Return-Path: <linux-efi+bounces-76-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B9D7F3D0D
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 05:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B923028280D
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 04:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBB8F4D;
	Wed, 22 Nov 2023 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTC07sXe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802CF4;
	Tue, 21 Nov 2023 20:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700629099; x=1732165099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6OOZDIt/V+EllWbRkUq5IJR0w5aDlkstgw6hwmoGvqE=;
  b=mTC07sXeg8tAtvXZ9wSuttiPjjV93Clf0qxwoAvyMmW4mVYbJAK/J9ZL
   +e6G0yModyqbodDTpL3bhxbIuDNyPqGvGdWSbEI2EES+a8UoipDWReb7T
   2SCYPkrkX157omCWheTVd+IjNSWAQWrqZRltbwiwKaKwacBlo6DQJaoKP
   u6ULLASiziBZu3SJfudenafKnswDuO/lofb339cXc/ilRFwgdcvbYaa0D
   2y45zSL4uVqCLbm+4bttBCMnshx+N8GtkZn8zwlJWdS7wyUW9K9PT13Ds
   hXP5/14bWr0XTvdjynBu8bvoo9FtfDov8rKAZrQ+6rssRjocBR6nXCSCe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10650220"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="10650220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 20:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795971891"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="795971891"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 20:58:13 -0800
Date: Wed, 22 Nov 2023 06:58:10 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org,
	will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
Message-ID: <ZV2KYqah4FHH4tnz@black.fi.intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-3-raag.jadav@intel.com>
 <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com>

On Tue, Nov 21, 2023 at 08:25:20PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 21, 2023 at 11:38 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > According to ACPI specification, a _UID object can evaluate to either
> > a numeric value or a string. Update acpi_dev_uid_match() helper to
> > support _UID matching for both integer and string types.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> You need to be careful with using this.  There are some things below
> that go beyond what I have suggested.

I think we all suggested some bits and pieces so I included everyone.
We can drop if there are any objections.

> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >  drivers/acpi/utils.c    | 19 -------------------
> >  include/acpi/acpi_bus.h | 35 ++++++++++++++++++++++++++++++++++-
> >  include/linux/acpi.h    |  8 +++-----
> >  3 files changed, 37 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index 28c75242fca9..fe7e850c6479 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -824,25 +824,6 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
> >  }
> >  EXPORT_SYMBOL(acpi_check_dsm);
> >
> > -/**
> > - * acpi_dev_uid_match - Match device by supplied UID
> > - * @adev: ACPI device to match.
> > - * @uid2: Unique ID of the device.
> > - *
> > - * Matches UID in @adev with given @uid2.
> > - *
> > - * Returns:
> > - *  - %true if matches.
> > - *  - %false otherwise.
> > - */
> > -bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> > -{
> > -       const char *uid1 = acpi_device_uid(adev);
> > -
> > -       return uid1 && uid2 && !strcmp(uid1, uid2);
> > -}
> > -EXPORT_SYMBOL_GPL(acpi_dev_uid_match);
> > -
> >  /**
> >   * acpi_dev_hid_uid_match - Match device by supplied HID and UID
> >   * @adev: ACPI device to match.
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index ec6a673dcb95..bcd78939bab4 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -9,6 +9,7 @@
> >  #ifndef __ACPI_BUS_H__
> >  #define __ACPI_BUS_H__
> >
> > +#include <linux/compiler.h>
> >  #include <linux/device.h>
> >  #include <linux/property.h>
> >
> > @@ -857,10 +858,42 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
> >                 adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
> >  }
> >
> > -bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2);
> >  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
> >  int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
> >
> > +static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2)
> > +{
> > +       const char *uid1 = acpi_device_uid(adev);
> > +
> > +       return uid1 && uid2 && !strcmp(uid1, uid2);
> > +}
> > +
> > +static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
> > +{
> > +       u64 uid1;
> > +
> > +       return !acpi_dev_uid_to_integer(adev, &uid1) && uid1 == uid2;
> > +}
> > +
> 
> Up to this point it is all fine IMV.
> 
> > +/**
> > + * acpi_dev_uid_match - Match device by supplied UID
> > + * @adev: ACPI device to match.
> > + * @uid2: Unique ID of the device.
> > + *
> > + * Matches UID in @adev with given @uid2.
> > + *
> > + * Returns: %true if matches, %false otherwise.
> > + */
> > +
> > +/* Treat uid as a string for array and pointer types, treat as an integer otherwise */
> > +#define get_uid_type(x) \
> > +       (__builtin_choose_expr(is_array_or_pointer_type(x), (const char *)0, (u64)0))
> 
> But I wouldn't use the above.
> 
> It is far more elaborate than needed for this use case and may not
> actually work as expected.  For instance, why would a pointer to a
> random struct type be a good candidate for a string?

Such case will not compile, since its data type will not match with
acpi_str_uid_match() prototype. The compiler does a very good job of
qualifing only the compatible string types here, which is exactly what
we want.

error: passing argument 2 of 'acpi_str_uid_match' from incompatible pointer type [-Werror=incompatible-pointer-types]
    if (acpi_dev_uid_match(adev, adev)) {
                                 ^
./include/acpi/acpi_bus.h:870:20: note: expected 'const char *' but argument is of type 'struct acpi_device *'
 static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2)

> > +
> > +#define acpi_dev_uid_match(adev, uid2)                         \
> > +       _Generic(get_uid_type(uid2),                            \
> > +                const char *: acpi_str_uid_match,              \
> > +                u64: acpi_int_uid_match)(adev, uid2)
> > +
> 
> Personally, I would just do something like the following
> 
> #define acpi_dev_uid_match(adev, uid2) \
>         _Generic((uid2), \
>                 const char *: acpi_str_uid_match, \
>                 char *: acpi_str_uid_match, \
>                 const void *: acpi_str_uid_match, \
>                 void *: acpi_str_uid_match, \
>                 default: acpi_int_uid_match)(adev, uid2)
> 
> which doesn't require compiler.h to be fiddled with and is rather
> straightforward to follow.
> 
> If I'm to apply the patches, this is about the level of complexity you
> need to target.

Understood, however this will limit the type support to only a handful
of types and will not satisfy a few of the existing users, which, for
example are passing signed or unsigned pointer or an array of u8.

Listing every possible type manually for _Generic() looks a bit verbose
for something that can be simply achieved by __builtin functions in my
opinion.

I can still send out a v3 to see if it really works. However, I prefer the
v2 approach, as it covers all possible scenarios without any corner cases.

Raag

