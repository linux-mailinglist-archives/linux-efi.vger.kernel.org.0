Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700BE2C26D8
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgKXNLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 08:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733262AbgKXNLB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Nov 2020 08:11:01 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E5520782
        for <linux-efi@vger.kernel.org>; Tue, 24 Nov 2020 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606223459;
        bh=FtC/gSH4zBgNeYIV7X9Y4FvH5ZKPw1lBf/GLkXM811c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=REYtYqKf12FqKZ2835gpzYlN598rb6dQsm+b1iiU4GCupeV2QOYYfqwe/c7U8Ol9u
         RO6lfNs48yh9ysF2yvI3DN9Tx1p7s4tl7SLIdvizC3lVk14PhbhomwymX/sgcKD6i5
         ftBKClEcXj7Thcx/jmZW6lfIxcBp/dLkzfHZ3xlI=
Received: by mail-ot1-f48.google.com with SMTP id l36so19270434ota.4
        for <linux-efi@vger.kernel.org>; Tue, 24 Nov 2020 05:10:59 -0800 (PST)
X-Gm-Message-State: AOAM530Qd+uxHIXmPQnY581WVgTIRz6wLCwLvqrNv/6/VzP338bZ7mcl
        JC16/3LILgaeHw0NdAFr790D3PiRO06nMUBwYqA=
X-Google-Smtp-Source: ABdhPJzh7lJsP+4t4o0Xcu6xbhnBo18S76DWYLYN5+Kbg6MmYpqqEXkG7gplCuLlaENlXRS+02MfQrsypKE4EJ73iAA=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr3034857otd.90.1606223458236;
 Tue, 24 Nov 2020 05:10:58 -0800 (PST)
MIME-Version: 1.0
References: <4898db16-7f9b-2efc-a5ae-356461d790b8@gmx.de> <4b74c0b7-7126-2829-29d3-ef5131c52b73@gmx.de>
 <CAMj1kXEy+SdBL2RbnF393scsOSGS-ACJX4QFuie-=HY99TpYRA@mail.gmail.com>
 <f69e20d9-99e5-e906-f991-30f6b0427bc7@gmx.de> <CAMj1kXF4gGR1w6r8rZmR7L-nTm8kS7UEAUr-ZA0==obOgLX43g@mail.gmail.com>
 <ebddb344-9888-d414-4f0d-5672e2e5868d@gmx.de> <CAMj1kXF5WDqrVp7ybGXdvU2pSqD1wXn_hmOs=w7rpyMHw2YGTw@mail.gmail.com>
 <acfdab1c-1c8b-ad42-3ea6-f69447aa7c54@gmx.de> <CAMj1kXG-CT7MgrC7w3PzVwwChDSRsiQfg35Md9OWQnLFYfbz5w@mail.gmail.com>
 <321008ae-f76e-4dc0-0aed-d9b4791738bd@gmx.de> <29e83bdb-08a9-f615-4f8b-2d310a9385eb@canonical.com>
 <CAMj1kXHpBxb125B38sv1Z+UFQ59cKLmNXRVSv1yTgrN21mpRtA@mail.gmail.com>
 <08821047-7452-0e07-afd8-e64488800618@canonical.com> <2cdf6cc8-e2f6-b416-92bf-3146c6110427@gmx.de>
In-Reply-To: <2cdf6cc8-e2f6-b416-92bf-3146c6110427@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Nov 2020 14:10:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXERVXkrb5kFwYjByR5Vz6BnYECkphGpsV6+hWGcDL=GwQ@mail.gmail.com>
Message-ID: <CAMj1kXERVXkrb5kFwYjByR5Vz6BnYECkphGpsV6+hWGcDL=GwQ@mail.gmail.com>
Subject: Re: fwts: RuntimeServicesSupported variable
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     ivanhu <ivan.hu@canonical.com>,
        Alex Hung <alex.hung@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        fwts-devel@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Nov 2020 at 14:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/20/20 9:22 AM, ivanhu wrote:
> >
> > On 10/20/20 2:46 PM, Ard Biesheuvel wrote:
> >> On Tue, 20 Oct 2020 at 08:20, ivanhu <ivan.hu@canonical.com> wrote:
> >>>
> >>> On 10/19/20 7:25 PM, Heinrich Schuchardt wrote:
> >>>> On 19.10.20 13:01, Ard Biesheuvel wrote:
> >>>>> On Mon, 19 Oct 2020 at 13:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>>>>> On 19.10.20 12:03, Ard Biesheuvel wrote:
> >>>>>>> On Mon, 19 Oct 2020 at 12:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>>>>>>> On 19.10.20 11:31, Ard Biesheuvel wrote:
> >>>>>>>>> On Wed, 14 Oct 2020 at 20:41, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>>>>>>>>> On 14.10.20 19:58, Ard Biesheuvel wrote:
> >>>>>>>>>>> On Wed, 14 Oct 2020 at 19:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>>>>>>>>>>> On 14.10.20 19:31, Heinrich Schuchardt wrote:
> >>>>>>>>>>>>> Dear all,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> the fwts fails on U-Boot due to testing for a non-existent
> >>>>>>>>>>>>> RuntimeServicesSupported variable.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> If you look at the UEFI specification 2.8 (Errata B) [1] you will
> >>>>>>>>>>>>> discover in the change log:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> 2.8 A2049
> >>>>>>>>>>>>> RuntimeServicesSupported EFI variable should be a config table
> >>>>>>>>>>>>> February 2020
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Please, read the configuration table to determine if a runtime service
> >>>>>>>>>>>>> is available on UEFI 2.8 systems.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On lower UEFI firmware version neither the variable nor the table exists.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Best regards
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Heinrich
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> [1] UEFI Specification Version 2.8 (Errata B) (released June 2020),
> >>>>>>>>>>>>> https://uefi.org/sites/default/files/resources/UEFI%20Spec%202.8B%20May%202020.pdf
> >>>>>>>>>>>>>
> >>>>>>>>>>>> Hello Ard,
> >>>>>>>>>>>>
> >>>>>>>>>>>> what is your idea how the EFI_RT_PROPERTIES_TABLE shall be exposed to
> >>>>>>>>>>>> the efi_test driver?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Will the EFI runtime wrapper simply return EFI_UNSUPPORTED if the
> >>>>>>>>>>>> function is not marked as supported in the table? Or will the
> >>>>>>>>>>>> configuration table itself be make available?
> >>>>>>>>>>>>
> >>>>>>>>>>> The UEFI spec permits that runtime services return EFI_UNSUPPORTED at
> >>>>>>>>>>> runtime, but requires that they are marked as such in the
> >>>>>>>>>>> EFI_RT_PROPERTIES_TABLE.
> >>>>>>>>>>>
> >>>>>>>>>>> So assuming that the purpose of efi_test is compliance with the spec,
> >>>>>>>>>>> it should only allow EFI_UNSUPPORTED as a return value for each of the
> >>>>>>>>>>> tested runtime services if it is omitted from
> >>>>>>>>>>> efi.runtime_supported_mask.
> >>>>>>>>>>>
> >>>>>>>>>>> Since the efi_test ioctl returns both an error code and the actual EFI
> >>>>>>>>>>> status code, we should only fail the call on a EFI_UNSUPPORTED status
> >>>>>>>>>>> code if the RTPROP mask does not allow that.
> >>>>>>>>>>>
> >>>>>>>>>>> E.g.,
> >>>>>>>>>>>
> >>>>>>>>>>> --- a/drivers/firmware/efi/test/efi_test.c
> >>>>>>>>>>> +++ b/drivers/firmware/efi/test/efi_test.c
> >>>>>>>>>>> @@ -265,7 +265,12 @@ static long efi_runtime_set_variable(unsigned long arg)
> >>>>>>>>>>>                  goto out;
> >>>>>>>>>>>          }
> >>>>>>>>>>>
> >>>>>>>>>>> -       rv = status == EFI_SUCCESS ? 0 : -EINVAL;
> >>>>>>>>>>> +       if (status == EFI_SUCCESS ||
> >>>>>>>>>>> +           (status == EFI_UNSUPPORTED &&
> >>>>>>>>>>> +            !efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)))
> >>>>>>>>>>> +               rv = 0;
> >>>>>>>>>>> +       else
> >>>>>>>>>>> +               rv = -EINVAL;
> >>>>>>>>>>>
> >>>>>>>>>>>   out:
> >>>>>>>>>>>          kfree(data);
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Do you think that could work?
> >>>>>>>>>>>
> >>>>>>>>>> The current fwts implementation assumes that EFI_UNSUPPORTED leads to
> >>>>>>>>>> ioctl() returning -1. This value should not be changed. It would be
> >>>>>>>>>> preferable to use another error code than -EINVAL, e.g. -EDOM if there
> >>>>>>>>>> is a mismatch with the EFI_RT_PROPERTIES_TABLE configuration table. Then
> >>>>>>>>>> a future verision of fwts can evaluate errno to discover the problem.
> >>>>>>>>>>
> >>>>>>>>>> Do I read you correctly: the EFI runtime wrapper does not fend of calls
> >>>>>>>>>> to runtime services marked as disallowed in EFI_RT_PROPERTIES_TABLE?
> >>>>>>>>>> Directly returning an error code might help to avoid crashes on
> >>>>>>>>>> non-compliant firmware.
> >>>>>>>>>>
> >>>>>>>>> It is not the kernel's job to work around non-compliant firmware. The
> >>>>>>>>> EFI spec is crystal clear that every runtime service needs to be
> >>>>>>>>> implemented, but is permitted to return EFI_UNSUPPORTED after
> >>>>>>>>> ExitBootServices(). This means EFI_RT_PROPERTIES_TABLE does not tell
> >>>>>>>>> you calling certain runtime services is disallowed, it tells you that
> >>>>>>>>> there is no point in even trying. That is why users such as efi-pstore
> >>>>>>>>> now take this information into account in their probe path (and
> >>>>>>>>> efivarfs will only mount read/write if SetVariable() is not marked as
> >>>>>>>>> unsupported).
> >>>>>>>>>
> >>>>>>>> How about the return code?
> >>>>>>>>
> >>>>>>> As I attempted to explain, I think EFI_UNSUPPORTED should not be
> >>>>>>> reported as an error if RT_PROP_TABLE permits it. The caller has
> >>>>>>> access to the raw efi_status_t that was returned, so it can
> >>>>>>> distinguish between the two cases.
> >>>>>>>
> >>>>>> The fwts tires to figure out if a firmware implementation is compliant.
> >>>>>>
> >>>>>> The return value according to you suggestion would be as follows
> >>>>>> depending on the UEFI status and the entry in EFI_RT_PROPERTIES_TABLE.
> >>>>>>
> >>>>>>            | EFI_SUCCESS  | EFI_UNSUPPORTED | EFI_INVALID_PARAMETER
> >>>>>> ----------|--------------|-----------------|----------------------
> >>>>>> Available |              |                 |
> >>>>>> according |     0        |   -EINVAL       |       -EINVAL
> >>>>>> EFT_RT_PRO|              |                 |
> >>>>>> -------------------------------------------------------------------
> >>>>>> Not       |              |                 |
> >>>>>> available |              |                 |
> >>>>>> according |     0        |       0         |       -EINVAL
> >>>>>> EFT_RT_PRO|              |                 |
> >>>>>> -------------------------------------------------------------------
> >>>>>>
> >>>>>> fwts would not be able to detect that according to the
> >>>>>> EFI_RT_PROPERTIES_TABLE the service is marked as not available
> >>>>>> but returns a value other than EFI_UNSUPPORTED.
> >>>>>>
> >>>>> But that would be permitted by the spec anyway. A runtime service is
> >>>>> not required to always return EFI_UNSUPPORTED if it is marked as
> >>>>> unavaialble in EFI_RT_PROP.
> >>>>>
> >>>> In the chapter "EFI_RT _PROPERTIES_TABLE" you can find this description:
> >>>>
> >>>> "*RuntimeServicesSupported* mask of which calls are or are not
> >>>> supported, where a bit set to 1 indicates that the call is supported,
> >>>> and 0 indicates that it is not."
> >>>>
> >>>> This leaves no room for implementing a service that is marked as not
> >>>> supported.
> >>>>
> >>>> In the descriptions of the return codes of the individual runtime services:
> >>>>
> >>>> "*EFI_UNSUPPORTED* This call is not supported by this platform at the
> >>>> time the call is made. The platform should describe this runtime service
> >>>> as unsupported at runtime via an EFI_RT_PROPERTIES_TABLE configuration
> >>>> table."
> >>>  From the spec, it clearly describes
> >>>
> >>> If a platform cannot support calls defined in EFI_RUNTIME_SERVICES after
> >>> ExitBootServices() is called, that platform is permitted to provide
> >>> implementations of those runtime services that return EFI_UNSUPPORTED
> >>> when invoked at runtime. On such systems, an EFI_RT_PROPERTIES_TABLE
> >>> configuration table should be published describing which runtime
> >>> services are supported at runtime.
> >>>
> >>> I think it's better not to modify efi_test base on the
> >>> EFI_RT_PROPERTIES_TABLE or RuntimeServicesSupported, let efi_test be
> >>> simply ioctl and FWTS tests can do the modifications.
> >>>
> >> Doesn't that mean FTWS would need to be able to access the
> >> EFI_RT_PROPERTIES_TABLE?
> >>
> > Right, FWTS need to be able to get the RuntimeServicesSupported value.
> >
> > I'm not sure if kernel will implement it or not, if not, maybe efi_test
> > can help to get and export the RuntimeServicesSupported from configure
> > table to FWTS.
>
> Hello Ard,
>
> what are you plans to get the issue solved?
>

No plans. Patches welcome.
