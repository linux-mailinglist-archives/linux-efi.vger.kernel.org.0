Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46128E5AC
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 19:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgJNRpS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 13:45:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:34969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgJNRpQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 14 Oct 2020 13:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602697511;
        bh=owguN5RUWFGq3s9vCR8SoKlReaog29Pvw1W1pZ3kigc=;
        h=X-UI-Sender-Class:Subject:From:To:References:Cc:Date:In-Reply-To;
        b=PgbTyVhP/1oqyf8X2nfFvBIYQ5JA3gEQ3CeSdaXbM05noG70KpfWshMTvlo3NUaSX
         K9BAzCBIDGIQdgILZAmyUwE47WShY/P7nDbzIWzvLij2keenPSzFJWI1MdDeo0phHE
         16qPuinjhG8suiRzkVXVP0xz7PSyJHaRcohdAScI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([178.202.41.107]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1kiVEX3QrX-00JZR9; Wed, 14
 Oct 2020 19:45:10 +0200
Subject: Re: fwts: RuntimeServicesSupported variable
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
References: <4898db16-7f9b-2efc-a5ae-356461d790b8@gmx.de>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <4b74c0b7-7126-2829-29d3-ef5131c52b73@gmx.de>
Date:   Wed, 14 Oct 2020 19:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4898db16-7f9b-2efc-a5ae-356461d790b8@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uS1u8sa1M6YKc//Ch4K+hOyFHfpjxsrWLrg8nZyWBNhsJw1kV0+
 usqr+OKmt6Vtus093IiF2RtGtPnjBY5vCEbH8PL4t6xqJOhQypZP4H4Lk8DNEC2ypuG2JkR
 lgVvzR4HWcCOEASeMMk06tniOFJm0UWAZ49FdtVAuOEhR5H1VGmwDG6WEU0eMcMJcOxaB/9
 xC/5i3EKvYE99i2NLDnRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ZOFXjjyyv8=:ug4CMmn6sIjtW26gjGF4C5
 xcpWZaMaOpa+Vglo892ioRlm+0XeOvfRGDaw6m6MVsT5Rbw8bOYjj3iN3kOYNCDJoS9FnIoTj
 gJ6Ub0c7juJYPupbRN63GlmEZ3H0Ne5ENMnwkcFKGjTBrmyJs8EkGJqWJMj3jxEjxxutgWDMQ
 3lg3keKGcNJoS9QmFGpgLkqy0j6jSpC3c9OgcpBBeiLmublzLMIEb/WXau3XddXiAnWh8X9yG
 iW5sp+cF70qUqawXhfpxnLdklMIcJQaXVw60cXfmldo7133qWgB+H6mgQ4I/UIRqyxCo2k7l/
 T2npcEQEYoJmoTFM61iC3nEv81N79iwb0rRTAGmNCiO12CwKHZh8ZaooVwh4Lp3u6LFG+ru0R
 DMur5sTDgQc+ShBSoXS8uuHeysKnfUGGzr7fQKaTXRlLHsZLRAWCzi9wZarY/6hIGSZ48IBac
 HdJ1KSJEMrB1roURPKvuoX9YgKBAjz6VwZcZPaxnCWKqyop7pGmvvkc4o/Sr6QzQqMxtgYGrg
 bXfZrc5tZSMoum4PS2ODDmv0Qp+ykL4RPNHW//zMIRE35oLOGUa8DCukM0ji+jAKj1kfEESI9
 ZULBbbgQuMjxc565jFD2TBFQnRFfAdP1C5P+CAV9sViT2ta6rcSsOt8hIR68w8yxV1gu7NlLy
 Yi934qSlRxrdJaG1bmOMVuWJBhePl92kNg3urE4Elk92cn+NcorcJ2eqYwat3AIKfH8XCZ8Bd
 popkllpscfFnRInLkSKyTp8TozXFlmSgLTqGWJt76oG9w/nusyCLGFoXmhJcQbm59foMl8lEU
 lumCDESmrr/uRcnaVwfThOBxNcAalKQsJ/dI0nDqxsgFZ7I9GQNN3lBh85IXbz0uW/yPotgM4
 9/aG2+z+//PyPbLHBorA==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 14.10.20 19:31, Heinrich Schuchardt wrote:
> Dear all,
>
> the fwts fails on U-Boot due to testing for a non-existent
> RuntimeServicesSupported variable.
>
> If you look at the UEFI specification 2.8 (Errata B) [1] you will
> discover in the change log:
>
> 2.8 A2049
> RuntimeServicesSupported EFI variable should be a config table
> February 2020
>
> Please, read the configuration table to determine if a runtime service
> is available on UEFI 2.8 systems.
>
> On lower UEFI firmware version neither the variable nor the table exists=
.
>
> Best regards
>
> Heinrich
>
> [1] UEFI Specification Version 2.8 (Errata B) (released June 2020),
> https://uefi.org/sites/default/files/resources/UEFI%20Spec%202.8B%20May%=
202020.pdf
>

Hello Ard,

what is your idea how the EFI_RT_PROPERTIES_TABLE shall be exposed to
the efi_test driver?

Will the EFI runtime wrapper simply return EFI_UNSUPPORTED if the
function is not marked as supported in the table? Or will the
configuration table itself be make available?

Best regards

Heinrich
