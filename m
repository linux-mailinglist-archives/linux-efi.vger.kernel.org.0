Return-Path: <linux-efi+bounces-1735-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1679780C6
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 15:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828881F2532B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E21DA62A;
	Fri, 13 Sep 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROM8zHz0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB271C2DBA
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233048; cv=none; b=EJXfC7wzOJOsNuCgDbgXNcP+lA4cAwaDVN5MmA+x1Wg0NnA34215hjxWVZAf340SoiG9YwvncNCO4mLpWR0CAn5MY4jP80bLZ+Pq8pQsD7B1a+npprTAHdL2VDCn1UTWJPg+YdDrXG0OvjDRut5nArOtE7xig38OfpnrejrBuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233048; c=relaxed/simple;
	bh=OFvq8yke0/IDCXgLS2cPimaSh01efgl5/tIuG8ZgukE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tj8sYdNSC6YkbyWMau4eNbwtLxVvIWJEiAWyUHMfmgTVg6+lcCejeKbme4Zf8Fw0A/Vsa7qAaiMnfZaL6y5z+G4Emtq4ORjL6k8GiMlZnyX2V7gvhlOm0SnK1T79KeK6DDsQu/C1LuX+CGGh/dHIeQSw1U8ljWUcaruOd9zZ0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROM8zHz0; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27b7a1480bdso934077fac.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726233045; x=1726837845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4oKliMfUMVg1aXxzTE0l3neUaGwA1Kbu5Zf+bM+74JA=;
        b=ROM8zHz0yp6LFOywkxRukCaamqf5IHdoUJuMiEq+1r3RgwcPpJgzZ3lFjZXlFMPCFM
         QH+eIhD0RqBoSpwNkcIAEP8ehTARhkj3Tu6sD9yz56bWgwZtoSnRMC2JQwB1AuwAojrb
         /I0P6Rql/XfhyPRp0RnGN5C2+y8qJJ2kI29pkVf5pkIT0kvayUr1wDPtx6NXbPJed9oE
         liBKK6sbW8tSzLyuXt2qXX3m1Nao+r5/kTEx8oozf5eRuySyaboa8r8r+R6AzEcCruHK
         bBxFRnI9KMAEqhgRaAec6bkZ22O63q45sgL74R/mYENUw64Y95x63ytoG7KkY220UJL+
         WfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233045; x=1726837845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oKliMfUMVg1aXxzTE0l3neUaGwA1Kbu5Zf+bM+74JA=;
        b=HC9rZiYsQ9SF1Ga2U0F2SJPbpx2KuI/hHNthLf86rD7Dx46cDlxyzLYdrcRfPmBgQU
         7mLkibRW/xF6ts7rtVq+7K0OuilMe+l0wj7trGduMUMAxjd8eRMxXdDuhQx33bOVcfT/
         Ubwsm6uPa2OJZRQCFDmiw3hAMZ5tIu4WTuuHTE4szrKlbTbv40Si6X4rOGsPLSLMXNUQ
         ZTL4qh1IUg2TV1ZyZ02xqqFLNu0NJeD3JAFkkinHe+/6fTgn31ZqBtnqL4NIvVCkllSh
         P+y8Y1skeMQ9a6Mc/XaS/RKG1vuUi3a5tzryPHiD/CALdkt8RxZiYbbkXu8551qjtqRj
         /aqA==
X-Gm-Message-State: AOJu0YwSlWJa8vcDzNFCGO0v+3sk6m4gSDyqV92+dhpjtrHfdUFJNQBi
	u1rjy4hH1+GbqSC1/gWNs6GD5GMvr6MAEeska89YE08oOXhK8CwLfUBtf1iQtLLGZPVd7lcmw23
	umxiGYLSzJmTFdvRnuMs6EFbNWweSIetchze9Yw==
X-Google-Smtp-Source: AGHT+IFu82D+7Sc8uv+eJuU71zTmpYlaWnT8Mb+zxAE4wtvkLRBCmJGMwnMM5dKbJ1Xc9GGptIhr44VyxZ1NjWdzYu8=
X-Received: by 2002:a05:6870:1952:b0:277:c084:5f75 with SMTP id
 586e51a60fabf-27c3f27160dmr3944492fac.18.1726233044834; Fri, 13 Sep 2024
 06:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-4-gourry@gourry.net>
 <CAC_iWj+uieGoH1ouc6nwdZjirULgjYk+H6YFQQHSHcAySdaFog@mail.gmail.com> <ZuQ2xmXo0FPZpJa-@PC2K9PVX.TheFacebook.com>
In-Reply-To: <ZuQ2xmXo0FPZpJa-@PC2K9PVX.TheFacebook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 16:10:08 +0300
Message-ID: <CAC_iWjKFmHUV4EzhfJ_OAHOZhrAzH35O8QMzVK_Zs2aTG5h+1Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] libstub,tpm: provide indication of failure when
 getting event log
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, ardb@kernel.org, 
	leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 15:58, Gregory Price <gourry@gourry.net> wrote:
>
> On Fri, Sep 13, 2024 at 09:59:03AM +0300, Ilias Apalodimas wrote:
> > Hi Gregory,
> >
> > On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> > >
> > > If get_event_log fails, at least provide an indicator of this failure
> > > to assist debugging later failures that attempt to interact with it.
> > >
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  drivers/firmware/efi/libstub/tpm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> > > index df3182f2e63a..192914e04e0f 100644
> > > --- a/drivers/firmware/efi/libstub/tpm.c
> > > +++ b/drivers/firmware/efi/libstub/tpm.c
> > > @@ -185,8 +185,10 @@ void efi_retrieve_eventlog(void)
> > >                         get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
> > >         }
> > >
> > > -       if (status != EFI_SUCCESS || !log_location)
> > > +       if (status != EFI_SUCCESS || !log_location) {
> > > +               efi_err("TPM unable to provide Event Log\n");
> >
> > s/provide/retrieve/ and yes the print is going to be useful.  Do you
> > know if the EventLog is mandatory. Reading at the spec GetEventlog
> > only has 2 return values, which implies you can't return "Not
> > supported", but it's not explicitly stated anywhere
> >
>
> I believe it is mandatory from my reading of the spec - but the
> "Final Event Log" was only added in 2.0.  We report an error when
> 2.0 is reported but the final event log is not supported, so i figure
> we should probably report when the event log fails as well.

Yea I am fine with that, I was just wondering if we should do _err or
_warn. I am fine with the error

/Ilias
>
> > Thanks
> > /Ilias
> > >                 return;
> > > +       }
> > >
> > >         efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> > >                                    truncated, final_events_table);
> > > --
> > > 2.43.0
> > >

