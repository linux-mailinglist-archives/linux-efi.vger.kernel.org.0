Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4925A29251A
	for <lists+linux-efi@lfdr.de>; Mon, 19 Oct 2020 12:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgJSKA4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Oct 2020 06:00:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:49769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgJSKA4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Oct 2020 06:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603101649;
        bh=gWw4ZEeMTrDIRIwhy2dBRgECCmiTv5zLBOD/nLez5YM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CrCYviRHdQa20zmRsQg/fNzp+/ZqepXP/C1VwJoXZVxjzSWtIspmeQJXPrS/LFp+p
         CK1nYr7To3aCb7PCUGWhwopPXAzL14HFwxwVp0rZWQ0ax938eQTqH62Ex08Fc7dJw3
         9So75TPIFHgf24RMjTh5fRpUTIawRsOky2ik5cVc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([178.202.41.107]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1kMoYP08OC-017S2z; Mon, 19
 Oct 2020 12:00:49 +0200
Subject: Re: fwts: RuntimeServicesSupported variable
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        fwts-devel@lists.ubuntu.com
References: <4898db16-7f9b-2efc-a5ae-356461d790b8@gmx.de>
 <4b74c0b7-7126-2829-29d3-ef5131c52b73@gmx.de>
 <CAMj1kXEy+SdBL2RbnF393scsOSGS-ACJX4QFuie-=HY99TpYRA@mail.gmail.com>
 <f69e20d9-99e5-e906-f991-30f6b0427bc7@gmx.de>
 <CAMj1kXF4gGR1w6r8rZmR7L-nTm8kS7UEAUr-ZA0==obOgLX43g@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <ebddb344-9888-d414-4f0d-5672e2e5868d@gmx.de>
Date:   Mon, 19 Oct 2020 12:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXF4gGR1w6r8rZmR7L-nTm8kS7UEAUr-ZA0==obOgLX43g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+2fP/+n0NrRZTHH0WYWCKNAUM5DJ0W08aJ5u9Wob8WiQrdkHlKK
 pvRIHV/p+eZ6kJQHfPSy7NLuuN67IR/zxFe6/jlVhi6mXC4jYKGx22WJWT4vjkf7SMQ7F9B
 xcZozYknZKeUmx3eBNc3q9O2uLmZx982qyMkAvyxg67r3ZrNZGmLYnYB1lj5Is/ZtNbwKag
 KeOjPtp/xTOwZpFGSvcPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xjyuYLo/7ds=:5WnfTmzhXioWrtjXJM0Qwq
 EzGJaob/qvykbWpShQagx949Xq74W2AkgXov1nyN6HWHmW69jyqLO3rwS20D7dzH0XPkDraP9
 TeGS8iGZiG6wmnQ3luGxYo+h+qOW32Rbq5tUKTu7SBS3LnjwKcuLnuim+jhpG6j1xAEMxJQ6i
 6zE/n0Hi6Hu932ESmoBh7Tp/i2eaUlDpC/HUxyvesP4W7u6L6Pa2OAY4GYmtKHE46e0Wbm4j7
 CzK08TABrTClx0h6K/IkkILQ6T+XR5ZNx8RZnTNBMYQgeC1ExAmqC/eZDvtEioYbRY7DNW2gm
 zYQFrOriFpder8ZvsHSTc//pXrSvEOROTFBQeJ08J+F/HgUcQ4II7lRlasFxhdb4ayGDA0HT2
 kv9Tio0q7fPolbT0aeYXjsmWjQR2d+4B3lhNiLKKLthUXmdUjeFbVFXu8U7qbpFia9bHbJQmd
 iAHjkwIDx/c59PyNy3x14VTd6dZdtds4GoL3u9Xto1gagDWax2qREYtQ0LAh51mWJpBJBmto+
 8oNi8vCMLSf+/oIkvbT5pDTXvrhyX0psdSg8AEXpZFTYgZ5/eu59+FES6KZta5/p5MAB8r+Nk
 qLWTSOwDuC+BeoG88o08+e890CYJRV39mDD7sWojyPX/JhS+ztZV0uGcRvUqe7mObLQYxOl/D
 +dF5OFeYBvGlE1B7uJCqYzXJcA08JG7moSlBwncns10yjGo8CKd6IfAe2I4quHU5QxTot74BN
 rD+AR4X7EQuVvw0Aga2uSOX+45ETOT20j3R7VEC12FfO/il3itkbVsCROMrfuweytdwKfu4B9
 y47nkbQUkDoSgNA0IwGP+4kkn4O1fZ3bSjJZ6Mo2GGM12cRObox29a6wxf/DVYdvuH0WKi2iI
 WN2iHIRY+93ta1v7vZ/w==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 19.10.20 11:31, Ard Biesheuvel wrote:
> On Wed, 14 Oct 2020 at 20:41, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 14.10.20 19:58, Ard Biesheuvel wrote:
>>> On Wed, 14 Oct 2020 at 19:45, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
>>>>
>>>> On 14.10.20 19:31, Heinrich Schuchardt wrote:
>>>>> Dear all,
>>>>>
>>>>> the fwts fails on U-Boot due to testing for a non-existent
>>>>> RuntimeServicesSupported variable.
>>>>>
>>>>> If you look at the UEFI specification 2.8 (Errata B) [1] you will
>>>>> discover in the change log:
>>>>>
>>>>> 2.8 A2049
>>>>> RuntimeServicesSupported EFI variable should be a config table
>>>>> February 2020
>>>>>
>>>>> Please, read the configuration table to determine if a runtime servi=
ce
>>>>> is available on UEFI 2.8 systems.
>>>>>
>>>>> On lower UEFI firmware version neither the variable nor the table ex=
ists.
>>>>>
>>>>> Best regards
>>>>>
>>>>> Heinrich
>>>>>
>>>>> [1] UEFI Specification Version 2.8 (Errata B) (released June 2020),
>>>>> https://uefi.org/sites/default/files/resources/UEFI%20Spec%202.8B%20=
May%202020.pdf
>>>>>
>>>>
>>>> Hello Ard,
>>>>
>>>> what is your idea how the EFI_RT_PROPERTIES_TABLE shall be exposed to
>>>> the efi_test driver?
>>>>
>>>> Will the EFI runtime wrapper simply return EFI_UNSUPPORTED if the
>>>> function is not marked as supported in the table? Or will the
>>>> configuration table itself be make available?
>>>>
>>>
>>> The UEFI spec permits that runtime services return EFI_UNSUPPORTED at
>>> runtime, but requires that they are marked as such in the
>>> EFI_RT_PROPERTIES_TABLE.
>>>
>>> So assuming that the purpose of efi_test is compliance with the spec,
>>> it should only allow EFI_UNSUPPORTED as a return value for each of the
>>> tested runtime services if it is omitted from
>>> efi.runtime_supported_mask.
>>>
>>> Since the efi_test ioctl returns both an error code and the actual EFI
>>> status code, we should only fail the call on a EFI_UNSUPPORTED status
>>> code if the RTPROP mask does not allow that.
>>>
>>> E.g.,
>>>
>>> --- a/drivers/firmware/efi/test/efi_test.c
>>> +++ b/drivers/firmware/efi/test/efi_test.c
>>> @@ -265,7 +265,12 @@ static long efi_runtime_set_variable(unsigned lon=
g arg)
>>>                 goto out;
>>>         }
>>>
>>> -       rv =3D status =3D=3D EFI_SUCCESS ? 0 : -EINVAL;
>>> +       if (status =3D=3D EFI_SUCCESS ||
>>> +           (status =3D=3D EFI_UNSUPPORTED &&
>>> +            !efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)=
))
>>> +               rv =3D 0;
>>> +       else
>>> +               rv =3D -EINVAL;
>>>
>>>  out:
>>>         kfree(data);
>>>
>>>
>>> Do you think that could work?
>>>
>>
>> The current fwts implementation assumes that EFI_UNSUPPORTED leads to
>> ioctl() returning -1. This value should not be changed. It would be
>> preferable to use another error code than -EINVAL, e.g. -EDOM if there
>> is a mismatch with the EFI_RT_PROPERTIES_TABLE configuration table. The=
n
>> a future verision of fwts can evaluate errno to discover the problem.
>>
>> Do I read you correctly: the EFI runtime wrapper does not fend of calls
>> to runtime services marked as disallowed in EFI_RT_PROPERTIES_TABLE?
>> Directly returning an error code might help to avoid crashes on
>> non-compliant firmware.
>>
>
> It is not the kernel's job to work around non-compliant firmware. The
> EFI spec is crystal clear that every runtime service needs to be
> implemented, but is permitted to return EFI_UNSUPPORTED after
> ExitBootServices(). This means EFI_RT_PROPERTIES_TABLE does not tell
> you calling certain runtime services is disallowed, it tells you that
> there is no point in even trying. That is why users such as efi-pstore
> now take this information into account in their probe path (and
> efivarfs will only mount read/write if SetVariable() is not marked as
> unsupported).
>

How about the return code?

Best regards

Heinrich
