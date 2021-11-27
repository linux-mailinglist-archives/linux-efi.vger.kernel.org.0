Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31045F782
	for <lists+linux-efi@lfdr.de>; Sat, 27 Nov 2021 01:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbhK0Ao4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Nov 2021 19:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhK0Am4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Nov 2021 19:42:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4013C061748;
        Fri, 26 Nov 2021 16:39:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D16A623BB;
        Sat, 27 Nov 2021 00:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ECDC004E1;
        Sat, 27 Nov 2021 00:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637973581;
        bh=PcOF56GVPiU5QNHH54WQ/qVEsJfSIIehARqsTZnkvTQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YYZm04gJJW8OseHRe5cYN9BoXPSeUWlZUCbFRzLWEUsDmtK+U5FhAqz5q7CVwR2BU
         qUaeqm08KvcJne3/mzr4QDiuR1lV7km04kdEUBxgxqorEXtnSK7pNP/9QzrI46y2Is
         Ff2+zUzi+ZmSrJZpC2oeXmbBh8JbenfJmY41rXv5Wgy6vXus3NMl/BvVo/BWqep3Qu
         Zq3/MphpE0Bq2ymYfwCenvC00hmSzussq4ttkkX35BloHhDjUXFxNV17MEpPkD3Kz+
         pAInmj11An10LehGnB1p+ds4sTye1km1wCaA+RnWr6m+q5MNWEHLbx+PAkP4mScs3S
         h43lkz6KrPv+Q==
Message-ID: <8ae595e00a1af8af398d99b5eea980011535334a.camel@kernel.org>
Subject: Re: [PATCH v8 03/17] integrity: Introduce a Linux keyring called
 machine
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Sat, 27 Nov 2021 02:39:39 +0200
In-Reply-To: <20211124044124.998170-4-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
> Many UEFI Linux distributions boot using shim.=C2=A0 The UEFI shim provid=
es
> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
> Boot DB and MOK keys to validate the next step in the boot chain.=C2=A0 T=
he
> MOK facility can be used to import user generated keys.=C2=A0 These keys =
can
> be used to sign an end-users development kernel build.=C2=A0 When Linux
> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
> .platform keyring.
>=20
> Define a new Linux keyring called machine.=C2=A0 This keyring shall conta=
in just
> MOK CA keys and not the remaining keys in the platform keyring. This new
> machine keyring will be used in follow on patches.=C2=A0 Unlike keys in t=
he
> platform keyring, keys contained in the machine keyring will be trusted
> within the kernel if the end-user has chosen to do so.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
