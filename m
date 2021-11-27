Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E345F78A
	for <lists+linux-efi@lfdr.de>; Sat, 27 Nov 2021 01:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbhK0Ar3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Nov 2021 19:47:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35028 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344152AbhK0Ap2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Nov 2021 19:45:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A01ABB82848;
        Sat, 27 Nov 2021 00:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A96C004E1;
        Sat, 27 Nov 2021 00:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637973732;
        bh=rwOyPvlEmtXSa5Y/qTy/aKSkVRduIddpl4hwGqd5JlA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FDH5Pa1Gp8TjcjkC9TvZdKpCkDxMmz7YRXJA8dt+8DR6ufFCnPVKM9h3H8LsAANL5
         fMu/nj72zvYJ7SawnRYjxw+ZRNbQ7iFfj/pas0khvNoSvw0MPZN5Q6iskWLnjBOdak
         Iew2o4pLU6Gu5ZSwd0koquN/dwyt/Txp09nO3dfJtCU9KMFD/B/lfcKYJFlLUTFWqg
         Igu7X0tFi2HLfwS72bbxqbKxt009Ys0Ts1ErKoqqKeLoVQmYxPjAjDqJ0gFi/H0vAz
         Jj3Qy4203DvO0JsrgW795j8a2PlJghAgKb2RFEvNTOb7yMzqWOTXkn/aWyyw0EM4Mq
         vddynk7wcOe3Q==
Message-ID: <2a03d34ea51fb258765ba1e0044eac673534be9e.camel@kernel.org>
Subject: Re: [PATCH v8 04/17] integrity: Do not allow machine keyring
 updates following init
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
Date:   Sat, 27 Nov 2021 02:42:09 +0200
In-Reply-To: <20211124044124.998170-5-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
> The machine keyring is setup during init.=C2=A0 No additional keys should=
 be
> allowed to be added afterwards.=C2=A0 Leave the permission as read only.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

For completeness (even if stating the obvious) it would be nice to
say explicitly why no additional keys are not allowed after the init.

/Jarkko
