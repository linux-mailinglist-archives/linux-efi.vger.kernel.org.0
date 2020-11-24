Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F52C290C
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 15:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgKXOJE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 09:09:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:39651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgKXOJE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Nov 2020 09:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606226935;
        bh=d8KFMefrzqhfsGXUWeo8BUy2cbgl4HiPh4N73F8cYW0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ac7TdMJIXDJQLagg/9uwk3hisiMyQT2q9hWC+7bAIsMITNUcM/LSWGUqQj9FAQKX6
         sOYOQnbjA48qHR7UbozeYd1WkdjlTYU6TYq3jXPsWSJB9emG9KbkZxK0ludLHPCEzi
         /+IGTQVyNl3hFh11p6gEXkhQs0lBt6UwQmeYgRqY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.83] ([62.143.246.89]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1kBtNj1mTs-015J8g; Tue, 24
 Nov 2020 15:08:55 +0100
Subject: Re: fwts: RuntimeServicesSupported variable
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ivanhu <ivan.hu@canonical.com>,
        Alex Hung <alex.hung@canonical.com>,
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
 <2cdf6cc8-e2f6-b416-92bf-3146c6110427@gmx.de>
 <CAMj1kXERVXkrb5kFwYjByR5Vz6BnYECkphGpsV6+hWGcDL=GwQ@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <f54d3241-1e38-c3e9-98e1-1c075a3b64ed@gmx.de>
Date:   Tue, 24 Nov 2020 15:08:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXERVXkrb5kFwYjByR5Vz6BnYECkphGpsV6+hWGcDL=GwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AB8XmflfiIEJnYJIOtaZ0CcopXuKZCK6kt+DqsqoxalQ2+3/Ocx
 MsVbhK5LXRbeD2dMifpdh1qGUa3dOL+4vGam4SJCB1TSjHg4ifYEChZ/vgsaaQiNaxZfeOH
 aNJHVUYXlfDXiq9x5Da5WNnGhZh77wdK+k1K88O4b1zyJPpftaMGg6Ymd5NvNE+CpSkJ0Ke
 Yu4iWbMejrYo1+Q3Xg+FQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4/q6fhEXdcQ=:VlUD2/6YTL/Ha1w/2p5Oub
 0iCBa44dKZG74hXPRY/psYlJETs5r16AoP423AoGIsFQblrV+4TTPKs0X3tzNqnBF2E49Hygo
 gY9Gm3a9OQnju3peT2YOymFmSy34Lo3KvPshWXZUQQ2qOVglMGSIa7t+PtIdGG5bt11tDOSfH
 0VzaE7mnJlqkycaXkE8x374MsZVtYVMEYcofYlFiCoKKXF3r4tERH7b573AIK4oaV8WLL6EH/
 dDLlNGNzYOZYdUjpzuIEVOlG/NtogtY6b2IhZN8VRQ36ZrSuJRWMibTYDLGU4gg3lZD3cWO16
 L0+btZU8YFPpYttEm6yI9isRb2lNuM2Gt2Tja/lCLnAvh8+fmU8b037A57Z+E+D6dg1QyaErK
 n8MX2YE39lFR2am/VByTaw2W0NxfEBnAwkQ6Dvm033HkcnH23x0pQ1USz1Y1hyy0wo10XZCKz
 wHw1AaT11Xer1K3erfkWFw5zXsJPBQ//Ddm+5APrTn/D/rRDoLX/O1lU8cVTRGiRLH6CGjWin
 ifKRRGlbxn3xKaN3EKe7JNtcmCSFL5Wa3gTTyGtoRoHsDhdglcR5nDZZGLMn7KG7gSKPct3iq
 yasXvGS2nSzZ3/ZkIhAmBAC1v0T1HzRVpo6EzvyqTYWkCf9+T3pwEuU/QPGpZMKxIiXdUFM60
 QkYEFg9/t8n5smmdZpmBGgN5XKF5hgbmDBNMEOfvvS0zeQr9C0AUApTdQmJ67ZskuoUwMm4z6
 HxIIHQq2BobRaE3ruh212qVTichjeQXxefzOG2Gsr+6pAFj8ABGft9G1mvoAN+t3/XKgxunFq
 19AZxvTB/W3XgbHsfpHBTXOHcv3hWVLfRkr7VYhM8sA18VhZV1knhlbliXWN7EUqyiCRzd4Aq
 Kmgbe/95KXx2mFQJVc1g==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/24/20 2:10 PM, Ard Biesheuvel wrote:
> On Tue, 24 Nov 2020 at 14:05, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 10/20/20 9:22 AM, ivanhu wrote:
>>>
>>> On 10/20/20 2:46 PM, Ard Biesheuvel wrote:
>>>> On Tue, 20 Oct 2020 at 08:20, ivanhu <ivan.hu@canonical.com> wrote:
>>>>>
>>>>> On 10/19/20 7:25 PM, Heinrich Schuchardt wrote:
>>>>>> On 19.10.20 13:01, Ard Biesheuvel wrote:
>>>>>>> On Mon, 19 Oct 2020 at 13:00, Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>>>>>>>> On 19.10.20 12:03, Ard Biesheuvel wrote:
>>>>>>>>> On Mon, 19 Oct 2020 at 12:00, Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>>>>>>>>>> On 19.10.20 11:31, Ard Biesheuvel wrote:
>>>>>>>>>>> On Wed, 14 Oct 2020 at 20:41, Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>>>>>>>>>>> On 14.10.20 19:58, Ard Biesheuvel wrote:
>>>>>>>>>>>>> On Wed, 14 Oct 2020 at 19:45, Heinrich Schuchardt <xypron.gl=
pk@gmx.de> wrote:
>>>>>>>>>>>>>> On 14.10.20 19:31, Heinrich Schuchardt wrote:
>>>>>>>>>>>>>>> Dear all,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> the fwts fails on U-Boot due to testing for a non-existent
>>>>>>>>>>>>>>> RuntimeServicesSupported variable.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If you look at the UEFI specification 2.8 (Errata B) [1] y=
ou will
>>>>>>>>>>>>>>> discover in the change log:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 2.8 A2049
>>>>>>>>>>>>>>> RuntimeServicesSupported EFI variable should be a config t=
able
>>>>>>>>>>>>>>> February 2020
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Please, read the configuration table to determine if a run=
time service
>>>>>>>>>>>>>>> is available on UEFI 2.8 systems.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On lower UEFI firmware version neither the variable nor th=
e table exists.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Best regards
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Heinrich
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [1] UEFI Specification Version 2.8 (Errata B) (released Ju=
ne 2020),
>>>>>>>>>>>>>>> https://uefi.org/sites/default/files/resources/UEFI%20Spec=
%202.8B%20May%202020.pdf
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hello Ard,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> what is your idea how the EFI_RT_PROPERTIES_TABLE shall be =
exposed to
>>>>>>>>>>>>>> the efi_test driver?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Will the EFI runtime wrapper simply return EFI_UNSUPPORTED =
if the
>>>>>>>>>>>>>> function is not marked as supported in the table? Or will t=
he
>>>>>>>>>>>>>> configuration table itself be make available?
>>>>>>>>>>>>>>
>>>>>>>>>>>>> The UEFI spec permits that runtime services return EFI_UNSUP=
PORTED at
>>>>>>>>>>>>> runtime, but requires that they are marked as such in the
>>>>>>>>>>>>> EFI_RT_PROPERTIES_TABLE.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So assuming that the purpose of efi_test is compliance with =
the spec,
>>>>>>>>>>>>> it should only allow EFI_UNSUPPORTED as a return value for e=
ach of the
>>>>>>>>>>>>> tested runtime services if it is omitted from
>>>>>>>>>>>>> efi.runtime_supported_mask.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Since the efi_test ioctl returns both an error code and the =
actual EFI
>>>>>>>>>>>>> status code, we should only fail the call on a EFI_UNSUPPORT=
ED status
>>>>>>>>>>>>> code if the RTPROP mask does not allow that.
>>>>>>>>>>>>>
>>>>>>>>>>>>> E.g.,
>>>>>>>>>>>>>
>>>>>>>>>>>>> --- a/drivers/firmware/efi/test/efi_test.c
>>>>>>>>>>>>> +++ b/drivers/firmware/efi/test/efi_test.c
>>>>>>>>>>>>> @@ -265,7 +265,12 @@ static long efi_runtime_set_variable(un=
signed long arg)
>>>>>>>>>>>>>                   goto out;
>>>>>>>>>>>>>           }
>>>>>>>>>>>>>
>>>>>>>>>>>>> -       rv =3D status =3D=3D EFI_SUCCESS ? 0 : -EINVAL;
>>>>>>>>>>>>> +       if (status =3D=3D EFI_SUCCESS ||
>>>>>>>>>>>>> +           (status =3D=3D EFI_UNSUPPORTED &&
>>>>>>>>>>>>> +            !efi_rt_services_supported(EFI_RT_SUPPORTED_SET=
_VARIABLE)))
>>>>>>>>>>>>> +               rv =3D 0;
>>>>>>>>>>>>> +       else
>>>>>>>>>>>>> +               rv =3D -EINVAL;
>>>>>>>>>>>>>
>>>>>>>>>>>>>    out:
>>>>>>>>>>>>>           kfree(data);
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Do you think that could work?
>>>>>>>>>>>>>
>>>>>>>>>>>> The current fwts implementation assumes that EFI_UNSUPPORTED =
leads to
>>>>>>>>>>>> ioctl() returning -1. This value should not be changed. It wo=
uld be
>>>>>>>>>>>> preferable to use another error code than -EINVAL, e.g. -EDOM=
 if there
>>>>>>>>>>>> is a mismatch with the EFI_RT_PROPERTIES_TABLE configuration =
table. Then
>>>>>>>>>>>> a future verision of fwts can evaluate errno to discover the =
problem.
>>>>>>>>>>>>
>>>>>>>>>>>> Do I read you correctly: the EFI runtime wrapper does not fen=
d of calls
>>>>>>>>>>>> to runtime services marked as disallowed in EFI_RT_PROPERTIES=
_TABLE?
>>>>>>>>>>>> Directly returning an error code might help to avoid crashes =
on
>>>>>>>>>>>> non-compliant firmware.
>>>>>>>>>>>>
>>>>>>>>>>> It is not the kernel's job to work around non-compliant firmwa=
re. The
>>>>>>>>>>> EFI spec is crystal clear that every runtime service needs to =
be
>>>>>>>>>>> implemented, but is permitted to return EFI_UNSUPPORTED after
>>>>>>>>>>> ExitBootServices(). This means EFI_RT_PROPERTIES_TABLE does no=
t tell
>>>>>>>>>>> you calling certain runtime services is disallowed, it tells y=
ou that
>>>>>>>>>>> there is no point in even trying. That is why users such as ef=
i-pstore
>>>>>>>>>>> now take this information into account in their probe path (an=
d
>>>>>>>>>>> efivarfs will only mount read/write if SetVariable() is not ma=
rked as
>>>>>>>>>>> unsupported).
>>>>>>>>>>>
>>>>>>>>>> How about the return code?
>>>>>>>>>>
>>>>>>>>> As I attempted to explain, I think EFI_UNSUPPORTED should not be
>>>>>>>>> reported as an error if RT_PROP_TABLE permits it. The caller has
>>>>>>>>> access to the raw efi_status_t that was returned, so it can
>>>>>>>>> distinguish between the two cases.
>>>>>>>>>
>>>>>>>> The fwts tires to figure out if a firmware implementation is comp=
liant.
>>>>>>>>
>>>>>>>> The return value according to you suggestion would be as follows
>>>>>>>> depending on the UEFI status and the entry in EFI_RT_PROPERTIES_T=
ABLE.
>>>>>>>>
>>>>>>>>             | EFI_SUCCESS  | EFI_UNSUPPORTED | EFI_INVALID_PARAME=
TER
>>>>>>>> ----------|--------------|-----------------|---------------------=
-
>>>>>>>> Available |              |                 |
>>>>>>>> according |     0        |   -EINVAL       |       -EINVAL
>>>>>>>> EFT_RT_PRO|              |                 |
>>>>>>>> -----------------------------------------------------------------=
--
>>>>>>>> Not       |              |                 |
>>>>>>>> available |              |                 |
>>>>>>>> according |     0        |       0         |       -EINVAL
>>>>>>>> EFT_RT_PRO|              |                 |
>>>>>>>> -----------------------------------------------------------------=
--
>>>>>>>>
>>>>>>>> fwts would not be able to detect that according to the
>>>>>>>> EFI_RT_PROPERTIES_TABLE the service is marked as not available
>>>>>>>> but returns a value other than EFI_UNSUPPORTED.
>>>>>>>>
>>>>>>> But that would be permitted by the spec anyway. A runtime service =
is
>>>>>>> not required to always return EFI_UNSUPPORTED if it is marked as
>>>>>>> unavaialble in EFI_RT_PROP.
>>>>>>>
>>>>>> In the chapter "EFI_RT _PROPERTIES_TABLE" you can find this descrip=
tion:
>>>>>>
>>>>>> "*RuntimeServicesSupported* mask of which calls are or are not
>>>>>> supported, where a bit set to 1 indicates that the call is supporte=
d,
>>>>>> and 0 indicates that it is not."
>>>>>>
>>>>>> This leaves no room for implementing a service that is marked as no=
t
>>>>>> supported.
>>>>>>
>>>>>> In the descriptions of the return codes of the individual runtime s=
ervices:
>>>>>>
>>>>>> "*EFI_UNSUPPORTED* This call is not supported by this platform at t=
he
>>>>>> time the call is made. The platform should describe this runtime se=
rvice
>>>>>> as unsupported at runtime via an EFI_RT_PROPERTIES_TABLE configurat=
ion
>>>>>> table."
>>>>>   From the spec, it clearly describes
>>>>>
>>>>> If a platform cannot support calls defined in EFI_RUNTIME_SERVICES a=
fter
>>>>> ExitBootServices() is called, that platform is permitted to provide
>>>>> implementations of those runtime services that return EFI_UNSUPPORTE=
D
>>>>> when invoked at runtime. On such systems, an EFI_RT_PROPERTIES_TABLE
>>>>> configuration table should be published describing which runtime
>>>>> services are supported at runtime.
>>>>>
>>>>> I think it's better not to modify efi_test base on the
>>>>> EFI_RT_PROPERTIES_TABLE or RuntimeServicesSupported, let efi_test be
>>>>> simply ioctl and FWTS tests can do the modifications.
>>>>>
>>>> Doesn't that mean FTWS would need to be able to access the
>>>> EFI_RT_PROPERTIES_TABLE?
>>>>
>>> Right, FWTS need to be able to get the RuntimeServicesSupported value.
>>>
>>> I'm not sure if kernel will implement it or not, if not, maybe efi_tes=
t
>>> can help to get and export the RuntimeServicesSupported from configure
>>> table to FWTS.
>>
>> Hello Ard,
>>
>> what are you plans to get the issue solved?
>>
>
> No plans. Patches welcome.
>

Hello Ard,

would a change like the following make sense to you?

Are there any unit tests for the efi_test module which would have to be
enhanced? I could not find anything in tools/testing/selftests/firmware.

diff --git a/drivers/firmware/efi/test/efi_test.c
b/drivers/firmware/efi/test/efi_test.c
index ddf9eae396fe..c9fa62378851 100644
=2D-- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -663,6 +663,19 @@ static long efi_runtime_query_capsulecaps(unsigned
long arg)
  	return rv;
  }

+static long efi_runtime_get_supported_mask(unsigned long arg)
+{
+	unsigned int __user *supported_mask;
+	int rv =3D 0;
+
+	runtime_services_supported =3D (unsigned int *)arg;
+
+	if (put_user(efi.runtime_supported_mask, supported_mask);
+		rv =3D -EFAULT;
+
+	return rv;
+}
+
  static long efi_test_ioctl(struct file *file, unsigned int cmd,
  							unsigned long arg)
  {
@@ -701,6 +714,9 @@ static long efi_test_ioctl(struct file *file,
unsigned int cmd,
  		return efi_runtime_reset_system(arg);
  	}

+	case EFI_RUNTIME_GET_SUPPORTED_MASK:
+		return efi_runtime_get_supported_mask(arg);
+
  	return -ENOTTY;
  }

diff --git a/drivers/firmware/efi/test/efi_test.h
b/drivers/firmware/efi/test/efi_test.h
index f2446aa1c2e3..117349e57993 100644
=2D-- a/drivers/firmware/efi/test/efi_test.h
+++ b/drivers/firmware/efi/test/efi_test.h
@@ -118,4 +118,7 @@ struct efi_resetsystem {
  #define EFI_RUNTIME_RESET_SYSTEM \
  	_IOW('p', 0x0B, struct efi_resetsystem)

+#define EFI_RUNTIME_GET_SUPPORTED_MASK \
+	_IOR('p', 0x0C, unsigned int)
+
  #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */

Best regards

Heinrich
