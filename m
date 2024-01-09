Return-Path: <linux-efi+bounces-378-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDB8290D9
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jan 2024 00:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1BAB24F07
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEDB3E479;
	Tue,  9 Jan 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulO6BLnB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735E3D553;
	Tue,  9 Jan 2024 23:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4A0C43394;
	Tue,  9 Jan 2024 23:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704843091;
	bh=5hVxyDqNgsjcjD9YxzQas3f5vsVGH6QVocKWVSXz16A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ulO6BLnBwTO1ExrIAtY/d6/8/t3snXWZ5xifzwxXvIe7aZNJ+xlEF2JN/Qa4xPmiH
	 2zQb3h1DbaxgJFvd/i2JCQc0l7jruCrcZRcAHOOLQxmLySFzJt8xVKm4pGGvoyUq/c
	 qIeXL/cSu3n+PO1WFX0BxEORZZ9GSneJjamd+aCIX3fUrwtJkeSxNO6CK8v3p20x/V
	 laBldAkwyL2cIpp+0ICO4q99vfUffGqOEobELr7nqpYZ0YLCwTU8vF938fZHegoHXg
	 H1WHiSHgO0wi8T1+8H4wl7+p5j/MvVQiT60nmsHbYCdXUCY8w7WZewbdp/zVdSuPE7
	 OVkKbSWGWiDUA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so3746527e87.1;
        Tue, 09 Jan 2024 15:31:30 -0800 (PST)
X-Gm-Message-State: AOJu0YymNeRm4S1ay5Jsykb9MAXzT/DxH7r45IQmkcxw0IQRaZNfaSXY
	Tb1JNi2LcITb0YG4OFjLZ7m/4fVTMawM+T93FDI=
X-Google-Smtp-Source: AGHT+IFxA8vGxIRBTWUyaiUZuldmYuGrjNaLStRYSK5aoQJzEJWovu97wR9lsnxNk+G0Wnl6ksNb7tZX4/MfBiBm75o=
X-Received: by 2002:a05:6512:3d8d:b0:50e:2bf0:dd6a with SMTP id
 k13-20020a0565123d8d00b0050e2bf0dd6amr51574lfv.13.1704843089198; Tue, 09 Jan
 2024 15:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20240108165855.00002f5a@Huawei.com> <eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
 <659caa8da651c_127da22947b@dwillia2-xfh.jf.intel.com.notmuch>
 <659cb0295ac1_8d749294b@iweiny-mobl.notmuch> <659cb684deb2d_127da22945a@dwillia2-xfh.jf.intel.com.notmuch>
 <20240109160435.00004a4a@Huawei.com> <659db15452090_24a8294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <659dd6ff5ee1_24a8294d0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <659dd6ff5ee1_24a8294d0@dwillia2-xfh.jf.intel.com.notmuch>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 10 Jan 2024 00:31:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHvJzLksPtj1_O2L+4zH4emEs5tnvFCq=Wysfr842b=Sg@mail.gmail.com>
Message-ID: <CAMj1kXHvJzLksPtj1_O2L+4zH4emEs5tnvFCq=Wysfr842b=Sg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2024 at 00:30, Dan Williams <dan.j.williams@intel.com> wrote=
:
>
> Dan Williams wrote:
> > Jonathan Cameron wrote:
> > > On Mon, 8 Jan 2024 18:59:16 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > Ira Weiny wrote:
> > > > > Dan Williams wrote:
> > > > > > Smita Koralahalli wrote:
> > > > > > > On 1/8/2024 8:58 AM, Jonathan Cameron wrote:
> > > > > > > > On Wed, 20 Dec 2023 16:17:27 -0800
> > > > > > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > > > > > >
> > > > > > > >> Series status/background
> > > > > > > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > >>
> > > > > > > >> Smita has been a great help with this series.  Thank you a=
gain!
> > > > > > > >>
> > > > > > > >> Smita's testing found that the GHES code ended up printing=
 the events
> > > > > > > >> twice.  This version avoids the duplicate print by calling=
 the callback
> > > > > > > >> from the GHES code instead of the EFI code as suggested by=
 Dan.
> > > > > > > >
> > > > > > > > I'm not sure this is working as intended.
> > > > > > > >
> > > > > > > > There is nothing gating the call in ghes_proc() of ghes_pri=
nt_estatus()
> > > > > > > > and now the EFI code handling that pretty printed things is=
 missing we get
> > > > > > > > the horrible kernel logging for an unknown block instead.
> > > > > > > >
> > > > > > > > So I think we need some minimal code in cper.c to match the=
 guids then not
> > > > > > > > log them (on basis we are arguing there is no need for new =
cper records).
> > > > > > > > Otherwise we are in for some messy kernel logs
> > > > > > > >
> > > > > > > > Something like:
> > > > > > > >
> > > > > > > > {1}[Hardware Error]: Hardware error from APEI Generic Hardw=
are Error Source: 1
> > > > > > > > {1}[Hardware Error]: event severity: recoverable
> > > > > > > > {1}[Hardware Error]:  Error 0, type: recoverable
> > > > > > > > {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260=
-417f-85a9-088b1621eba6
> > > > > > > > {1}[Hardware Error]:   section length: 0x90
> > > > > > > > {1}[Hardware Error]:   00000000: 00000090 00000007 00000000=
 0d938086  ................
> > > > > > > > {1}[Hardware Error]:   00000010: 00100000 00000000 00040000=
 00000000  ................
> > > > > > > > {1}[Hardware Error]:   00000020: 00000000 00000000 00000000=
 00000000  ................
> > > > > > > > {1}[Hardware Error]:   00000030: 00000000 00000000 00000000=
 00000000  ................
> > > > > > > > {1}[Hardware Error]:   00000040: 00000000 00000000 00000000=
 00000000  ................
> > > > > > > > {1}[Hardware Error]:   00000050: 00000000 00000000 00000000=
 00000000  ................
> > > > > > > > {1}[Hardware Error]:   00000060: 00000000 00000000 00000000=
 00000000  ................
> > > > > > > > {1}[Hardware Error]:   00000070: 00000000 00000000 00000000=
 00000000  ................
> > > > > > > > {1}[Hardware Error]:   00000080: 00000000 00000000 00000000=
 00000000  ................
> > > > > > > > cxl_general_media: memdev=3Dmem1 host=3D0000:10:00.0 serial=
=3D4 log=3DInformational : time=3D0 uuid=3Dfbcd0a77-c260-417f-85a9-088b1621=
eba6 len=3D0 flags=3D'' handle=3D0 related_handle=3D0 maint_op_class=3D0 : =
dpa=3D0 dpa_flags=3D'' descriptor=3D'' type=3D'ECC Error' transaction_type=
=3D'Unknown' channel=3D0 rank=3D0 device=3D0 comp_id=3D00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 validity_flags=3D''
> > > > > > > >
> > > > > > > > (I'm filling the record with 0s currently)
> > > > > > >
> > > > > > > Yeah, when I tested this, I thought its okay for the hexdump =
to be there
> > > > > > > in dmesg from EFI as the handling is done in trace events fro=
m GHES.
> > > > > > >
> > > > > > > If, we need to handle from EFI, then it would be a good reaso=
n to move
> > > > > > > the GUIDs out from GHES and place it in a common location for=
 EFI/cper
> > > > > > > to share similar to protocol errors.
> > > > > >
> > > > > > Ah, yes, my expectation was more aligned with Jonathan's observ=
ation to
> > > > > > do the processing in GHES code *and* skip the processing in the=
 CPER
> > > > > > code, something like:
> > > > > >
> > > > >
> > > > > Agreed this was intended I did not realize the above.
> > > > >
> > > > > >
> > > > > > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi=
/cper.c
> > > > > > index 35c37f667781..0a4eed470750 100644
> > > > > > --- a/drivers/firmware/efi/cper.c
> > > > > > +++ b/drivers/firmware/efi/cper.c
> > > > > > @@ -24,6 +24,7 @@
> > > > > >  #include <linux/bcd.h>
> > > > > >  #include <acpi/ghes.h>
> > > > > >  #include <ras/ras_event.h>
> > > > > > +#include <linux/cxl-event.h>
> > > > > >  #include "cper_cxl.h"
> > > > > >
> > > > > >  /*
> > > > > > @@ -607,6 +608,15 @@ cper_estatus_print_section(const char *pfx=
, struct acpi_hest_generic_data *gdata
> > > > > >                       cper_print_prot_err(newpfx, prot_err);
> > > > > >               else
> > > > > >                       goto err_section_too_small;
> > > > > > +     } else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_G=
UID)) {
> > > > > > +             printk("%ssection_type: CXL General Media Error\n=
", newpfx);
> > > > >
> > > > > Do we want the printk's here?  I did not realize that a generic e=
vent
> > > > > would be printed.  So intention was nothing would be done on this=
 path.
> > > >
> > > > I think we do otherwise the kernel will say
> > > >
> > > >     {1}[Hardware Error]: Hardware error from APEI Generic Hardware =
Error Source: 1
> > > >     {1}[Hardware Error]: event severity: recoverable
> > > >     {1}[Hardware Error]:  Error 0, type: recoverable
> > > >     ...
> > > >
> > > > ...leaving the user hanging vs:
> > > >
> > > >     {1}[Hardware Error]: Hardware error from APEI Generic Hardware =
Error Source: 1
> > > >     {1}[Hardware Error]: event severity: recoverable
> > > >     {1}[Hardware Error]:  Error 0, type: recoverable
> > > >     {1}[Hardware Error]:   section type: General Media Error
> > > >
> > > > ...as an indicator to go follow up with rasdaemon or whatever else =
is
> > > > doing the detailed monitoring of CXL events.
> > >
> > > Agreed. Maybe push it out to a static const table though.
> > > As the argument was that we shouldn't be spitting out big logs in thi=
s
> > > modern world, let's make it easy for people to add more entries.
> > >
> > > struct skip_me {
> > >     guid_t guid;
> > >     const char *name;
> > > };
> > > static const struct skip_me skip_me =3D {
> > >     { &CPER_SEC_CXL_GEN_MEDIA, "CXL General Media Error" },
> > > etc.
> > > };
> > >
> > > for (i =3D 0; i < ARRAY_SIZE(skip_me); i++) {
> > >     if (guid_equal(sec_type, skip_me[i].guid)) {
> > >             printk("%asection_type: %s\n", newpfx, skip_me[i].name);
> > >             break;
> > > }
> > >
> > > or something like that in the final else.
> >
> > I like it.
> >
> > Any concerns with that being an -rc fixup, and move ahead with the base
> > enabling for v6.8? I don't see that follow-on as a reason to push the
> > whole thing to v6.9.
>
> I will put it in -next for soak time and make an inclusion decision in a
> few days after I hear back.
>

For the series and however you want to handle the merge:

Acked-by: Ard Biesheuvel <ardb@kernel.org>

