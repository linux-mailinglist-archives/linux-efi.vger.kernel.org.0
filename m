Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC092C26C2
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 14:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgKXNFp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 08:05:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:38153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732763AbgKXNFp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Nov 2020 08:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606223137;
        bh=zDNEUUNXRDfv6Z0RUIPxPaSW8rCQnieUOqMnhli/zE0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ccGi302qFh624vi0V+1lzQz3DCHYuFfnSU2nBJePKI4aDv54tNkF7ES58co5V56yk
         C8l/oC+yKf1o9ReFsAfOB2tmtk6trlk/NUx8sbNnJInVX7wPivRSbRAZYqIhCBR/aT
         XieB8W+SNZfXavXW98ySjc9K3hIB20nUIx4yVRK4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.83] ([62.143.246.89]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhlf-1kXxDz4Ao3-00ApUR; Tue, 24
 Nov 2020 14:05:37 +0100
Subject: Re: fwts: RuntimeServicesSupported variable
To:     ivanhu <ivan.hu@canonical.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        fwts-devel@lists.ubuntu.com
References: <4898db16-7f9b-2efc-a5ae-356461d790b8@gmx.de>
 <4b74c0b7-7126-2829-29d3-ef5131c52b73@gmx.de>
 <CAMj1kXEy+SdBL2RbnF393scsOSGS-ACJX4QFuie-=HY99TpYRA@mail.gmail.com>
 <f69e20d9-99e5-e906-f991-30f6b0427bc7@gmx.de>
 <CAMj1kXF4gGR1w6r8rZmR7L-nTm8kS7UEAUr-ZA0==obOgLX43g@mail.gmail.com>
 <ebddb344-9888-d414-4f0d-5672e2e5868d@gmx.de>
 <CAMj1kXF5WDqrVp7ybGXdvU2pSqD1wXn_hmOs=w7rpyMHw2YGTw@mail.gmail.com>
 <acfdab1c-1c8b-ad42-3ea6-f69447aa7c54@gmx.de>
 <CAMj1kXG-CT7MgrC7w3PzVwwChDSRsiQfg35Md9OWQnLFYfbz5w@mail.gmail.com>
 <321008ae-f76e-4dc0-0aed-d9b4791738bd@gmx.de>
 <29e83bdb-08a9-f615-4f8b-2d310a9385eb@canonical.com>
 <CAMj1kXHpBxb125B38sv1Z+UFQ59cKLmNXRVSv1yTgrN21mpRtA@mail.gmail.com>
 <08821047-7452-0e07-afd8-e64488800618@canonical.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <2cdf6cc8-e2f6-b416-92bf-3146c6110427@gmx.de>
Date:   Tue, 24 Nov 2020 14:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <08821047-7452-0e07-afd8-e64488800618@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n/y9w3qF5HFZx5gckFjx+nQuNipEarzn8H+TO/AA/WUURT4wQKZ
 znbnQFIhTS7XgfZ3qYPDsuAppPlf3oWgPwphSVhLkHgmZ2A5NpzdAn/NMZ/ndR6ZyoU9fWL
 7nh5zmzZPiv6QMcMzIvtSiK4SPkbCWFJdn+i72RACrt/gyC7X95MHEpqLqVtNtG+6EpEfya
 EJ7brEk9KSI81TCVEnnlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X29f266vy6U=:Mh64J8Dmwsaz60QczzRm49
 f8M7bjZ3WA4UR70IRGs9BEQvw9sHvMWOFmgy0SDaLrwL+uf9msYbQYo4IjM8UIlU4XMBfaOak
 LK54pEzHVWvA1EH9p+Xxr5VGF+PY/kPSh9yHGA30yXPGxQ8t3ehAj5uDCuWmIdGgsyYMRRdDU
 o8iY5Lx1R8ZK4Y0JeK60tadkeuovXOcU1k+K52Kg1eUgW2IIYpmZTcMTEhi39rlN8mwaL4HaZ
 9YC9LOzUASa6QRfv4Vr+s1VTwDfGrzV/RPQ9Ht0fyU/7DHXFhYr5aERoxrdJEKXff6q5X25lk
 k6U8/Qk1VJlSpE8xEKPv9nxM5rPPJo/tRQu0lbKnN2VxSzGHg6xbdIMnz2cT0K+nv2gK8rjkn
 cCPMsLB2m9jjlHCR33XkOnhMpGtC027jVSMXTfS2W2K78WpkY52ISLeRe2h68+bmXBS7JXti3
 Ypt8XUz6P/VtUWDDxr2pDmnIBMxhO0VyZXOa3i89OHE8JSvmJL34Ak0LmwM9zHkzNDbetWjmh
 BfjessmUpBMA3tsFiURALKfa0rdd8j0Dc+7knmJI1kXqS7z/vtD6pm6vJl539eO1K5txot/Rw
 UP8oHcMd4DlQMClJyJ5hJCPMxmho8xzONmSsO+DOf04LtP2DrgBm6L/gwVUNTpYvOqD2LvVGP
 DlJbatqod9vC1hd0otPLJhaM21xyeEsea3KA3IxxFO7DfXRms7rFLR2vtsBvHey04vdZU/fQa
 /Ilhrik75cLyYy8JP+6aB+n3SFyN9SIbMu+8pzOKQhIDRViQJh9mu5+WScqxZsYqQftQS30/7
 zx8C6VCmWlY9A3B+AbaEBWT9HT5esJC+8mURSIs4yaKBgBRDDO+SgXwusSuCK97w+oLRQV5hg
 +VOhvkjv2Xha5X++/vfQ==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/20/20 9:22 AM, ivanhu wrote:
>
> On 10/20/20 2:46 PM, Ard Biesheuvel wrote:
>> On Tue, 20 Oct 2020 at 08:20, ivanhu <ivan.hu@canonical.com> wrote:
>>>
>>> On 10/19/20 7:25 PM, Heinrich Schuchardt wrote:
>>>> On 19.10.20 13:01, Ard Biesheuvel wrote:
>>>>> On Mon, 19 Oct 2020 at 13:00, Heinrich Schuchardt <xypron.glpk@gmx.d=
e> wrote:
>>>>>> On 19.10.20 12:03, Ard Biesheuvel wrote:
>>>>>>> On Mon, 19 Oct 2020 at 12:00, Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>>>>>>>> On 19.10.20 11:31, Ard Biesheuvel wrote:
>>>>>>>>> On Wed, 14 Oct 2020 at 20:41, Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>>>>>>>>>> On 14.10.20 19:58, Ard Biesheuvel wrote:
>>>>>>>>>>> On Wed, 14 Oct 2020 at 19:45, Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>>>>>>>>>>> On 14.10.20 19:31, Heinrich Schuchardt wrote:
>>>>>>>>>>>>> Dear all,
>>>>>>>>>>>>>
>>>>>>>>>>>>> the fwts fails on U-Boot due to testing for a non-existent
>>>>>>>>>>>>> RuntimeServicesSupported variable.
>>>>>>>>>>>>>
>>>>>>>>>>>>> If you look at the UEFI specification 2.8 (Errata B) [1] you=
 will
>>>>>>>>>>>>> discover in the change log:
>>>>>>>>>>>>>
>>>>>>>>>>>>> 2.8 A2049
>>>>>>>>>>>>> RuntimeServicesSupported EFI variable should be a config tab=
le
>>>>>>>>>>>>> February 2020
>>>>>>>>>>>>>
>>>>>>>>>>>>> Please, read the configuration table to determine if a runti=
me service
>>>>>>>>>>>>> is available on UEFI 2.8 systems.
>>>>>>>>>>>>>
>>>>>>>>>>>>> On lower UEFI firmware version neither the variable nor the =
table exists.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Best regards
>>>>>>>>>>>>>
>>>>>>>>>>>>> Heinrich
>>>>>>>>>>>>>
>>>>>>>>>>>>> [1] UEFI Specification Version 2.8 (Errata B) (released June=
 2020),
>>>>>>>>>>>>> https://uefi.org/sites/default/files/resources/UEFI%20Spec%2=
02.8B%20May%202020.pdf
>>>>>>>>>>>>>
>>>>>>>>>>>> Hello Ard,
>>>>>>>>>>>>
>>>>>>>>>>>> what is your idea how the EFI_RT_PROPERTIES_TABLE shall be ex=
posed to
>>>>>>>>>>>> the efi_test driver?
>>>>>>>>>>>>
>>>>>>>>>>>> Will the EFI runtime wrapper simply return EFI_UNSUPPORTED if=
 the
>>>>>>>>>>>> function is not marked as supported in the table? Or will the
>>>>>>>>>>>> configuration table itself be make available?
>>>>>>>>>>>>
>>>>>>>>>>> The UEFI spec permits that runtime services return EFI_UNSUPPO=
RTED at
>>>>>>>>>>> runtime, but requires that they are marked as such in the
>>>>>>>>>>> EFI_RT_PROPERTIES_TABLE.
>>>>>>>>>>>
>>>>>>>>>>> So assuming that the purpose of efi_test is compliance with th=
e spec,
>>>>>>>>>>> it should only allow EFI_UNSUPPORTED as a return value for eac=
h of the
>>>>>>>>>>> tested runtime services if it is omitted from
>>>>>>>>>>> efi.runtime_supported_mask.
>>>>>>>>>>>
>>>>>>>>>>> Since the efi_test ioctl returns both an error code and the ac=
tual EFI
>>>>>>>>>>> status code, we should only fail the call on a EFI_UNSUPPORTED=
 status
>>>>>>>>>>> code if the RTPROP mask does not allow that.
>>>>>>>>>>>
>>>>>>>>>>> E.g.,
>>>>>>>>>>>
>>>>>>>>>>> --- a/drivers/firmware/efi/test/efi_test.c
>>>>>>>>>>> +++ b/drivers/firmware/efi/test/efi_test.c
>>>>>>>>>>> @@ -265,7 +265,12 @@ static long efi_runtime_set_variable(unsi=
gned long arg)
>>>>>>>>>>>                  goto out;
>>>>>>>>>>>          }
>>>>>>>>>>>
>>>>>>>>>>> -       rv =3D status =3D=3D EFI_SUCCESS ? 0 : -EINVAL;
>>>>>>>>>>> +       if (status =3D=3D EFI_SUCCESS ||
>>>>>>>>>>> +           (status =3D=3D EFI_UNSUPPORTED &&
>>>>>>>>>>> +            !efi_rt_services_supported(EFI_RT_SUPPORTED_SET_V=
ARIABLE)))
>>>>>>>>>>> +               rv =3D 0;
>>>>>>>>>>> +       else
>>>>>>>>>>> +               rv =3D -EINVAL;
>>>>>>>>>>>
>>>>>>>>>>>   out:
>>>>>>>>>>>          kfree(data);
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Do you think that could work?
>>>>>>>>>>>
>>>>>>>>>> The current fwts implementation assumes that EFI_UNSUPPORTED le=
ads to
>>>>>>>>>> ioctl() returning -1. This value should not be changed. It woul=
d be
>>>>>>>>>> preferable to use another error code than -EINVAL, e.g. -EDOM i=
f there
>>>>>>>>>> is a mismatch with the EFI_RT_PROPERTIES_TABLE configuration ta=
ble. Then
>>>>>>>>>> a future verision of fwts can evaluate errno to discover the pr=
oblem.
>>>>>>>>>>
>>>>>>>>>> Do I read you correctly: the EFI runtime wrapper does not fend =
of calls
>>>>>>>>>> to runtime services marked as disallowed in EFI_RT_PROPERTIES_T=
ABLE?
>>>>>>>>>> Directly returning an error code might help to avoid crashes on
>>>>>>>>>> non-compliant firmware.
>>>>>>>>>>
>>>>>>>>> It is not the kernel's job to work around non-compliant firmware=
. The
>>>>>>>>> EFI spec is crystal clear that every runtime service needs to be
>>>>>>>>> implemented, but is permitted to return EFI_UNSUPPORTED after
>>>>>>>>> ExitBootServices(). This means EFI_RT_PROPERTIES_TABLE does not =
tell
>>>>>>>>> you calling certain runtime services is disallowed, it tells you=
 that
>>>>>>>>> there is no point in even trying. That is why users such as efi-=
pstore
>>>>>>>>> now take this information into account in their probe path (and
>>>>>>>>> efivarfs will only mount read/write if SetVariable() is not mark=
ed as
>>>>>>>>> unsupported).
>>>>>>>>>
>>>>>>>> How about the return code?
>>>>>>>>
>>>>>>> As I attempted to explain, I think EFI_UNSUPPORTED should not be
>>>>>>> reported as an error if RT_PROP_TABLE permits it. The caller has
>>>>>>> access to the raw efi_status_t that was returned, so it can
>>>>>>> distinguish between the two cases.
>>>>>>>
>>>>>> The fwts tires to figure out if a firmware implementation is compli=
ant.
>>>>>>
>>>>>> The return value according to you suggestion would be as follows
>>>>>> depending on the UEFI status and the entry in EFI_RT_PROPERTIES_TAB=
LE.
>>>>>>
>>>>>>            | EFI_SUCCESS  | EFI_UNSUPPORTED | EFI_INVALID_PARAMETER
>>>>>> ----------|--------------|-----------------|----------------------
>>>>>> Available |              |                 |
>>>>>> according |     0        |   -EINVAL       |       -EINVAL
>>>>>> EFT_RT_PRO|              |                 |
>>>>>> -------------------------------------------------------------------
>>>>>> Not       |              |                 |
>>>>>> available |              |                 |
>>>>>> according |     0        |       0         |       -EINVAL
>>>>>> EFT_RT_PRO|              |                 |
>>>>>> -------------------------------------------------------------------
>>>>>>
>>>>>> fwts would not be able to detect that according to the
>>>>>> EFI_RT_PROPERTIES_TABLE the service is marked as not available
>>>>>> but returns a value other than EFI_UNSUPPORTED.
>>>>>>
>>>>> But that would be permitted by the spec anyway. A runtime service is
>>>>> not required to always return EFI_UNSUPPORTED if it is marked as
>>>>> unavaialble in EFI_RT_PROP.
>>>>>
>>>> In the chapter "EFI_RT _PROPERTIES_TABLE" you can find this descripti=
on:
>>>>
>>>> "*RuntimeServicesSupported* mask of which calls are or are not
>>>> supported, where a bit set to 1 indicates that the call is supported,
>>>> and 0 indicates that it is not."
>>>>
>>>> This leaves no room for implementing a service that is marked as not
>>>> supported.
>>>>
>>>> In the descriptions of the return codes of the individual runtime ser=
vices:
>>>>
>>>> "*EFI_UNSUPPORTED* This call is not supported by this platform at the
>>>> time the call is made. The platform should describe this runtime serv=
ice
>>>> as unsupported at runtime via an EFI_RT_PROPERTIES_TABLE configuratio=
n
>>>> table."
>>>  From the spec, it clearly describes
>>>
>>> If a platform cannot support calls defined in EFI_RUNTIME_SERVICES aft=
er
>>> ExitBootServices() is called, that platform is permitted to provide
>>> implementations of those runtime services that return EFI_UNSUPPORTED
>>> when invoked at runtime. On such systems, an EFI_RT_PROPERTIES_TABLE
>>> configuration table should be published describing which runtime
>>> services are supported at runtime.
>>>
>>> I think it's better not to modify efi_test base on the
>>> EFI_RT_PROPERTIES_TABLE or RuntimeServicesSupported, let efi_test be
>>> simply ioctl and FWTS tests can do the modifications.
>>>
>> Doesn't that mean FTWS would need to be able to access the
>> EFI_RT_PROPERTIES_TABLE?
>>
> Right, FWTS need to be able to get the RuntimeServicesSupported value.
>
> I'm not sure if kernel will implement it or not, if not, maybe efi_test
> can help to get and export the RuntimeServicesSupported from configure
> table to FWTS.

Hello Ard,

what are you plans to get the issue solved?

Best regards

Heinrich
