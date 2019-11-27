Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6D10BDAD
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2019 22:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfK0Van (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Nov 2019 16:30:43 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:36718 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbfK0Vam (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Nov 2019 16:30:42 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6ECFA1C228B; Wed, 27 Nov 2019 22:30:38 +0100 (CET)
Date:   Wed, 27 Nov 2019 22:30:37 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 11/12] ACPI/sleep: Convert acpi_wakeup_address into a
 function
Message-ID: <20191127213037.GB20612@amd>
References: <20191126165417.22423-1-sean.j.christopherson@intel.com>
 <20191126165417.22423-12-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20191126165417.22423-12-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-11-26 08:54:16, Sean Christopherson wrote:
> Convert acpi_wakeup_address from a raw variable into a function so that
> x86 can wrap its dereference of the real mode boot header in a function
> instead of broadcasting it to the world via a #define.  This sets the
> stage for a future patch to move x86's definition of the new function,
> acpi_get_wakeup_address(), out of asm/acpi.h and thus break acpi.h's
> dependency on asm/realmode.h.
>=20
> No functional change intended.
>=20
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Thanks!

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3e6v0ACgkQMOfwapXb+vIvKgCgj+csmgRVJU3LjSgRtQ9xs4OL
1n8An0cFCD4JerAugYVERVISU8Tw+N8s
=cvdZ
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
