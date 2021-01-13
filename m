Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457902F5560
	for <lists+linux-efi@lfdr.de>; Thu, 14 Jan 2021 01:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhAMX7P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Jan 2021 18:59:15 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:35902 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729673AbhAMX5X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Jan 2021 18:57:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 111BD1280967;
        Wed, 13 Jan 2021 15:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610582202;
        bh=q5pGq2KcrqVHwr6DWLs6LIeKvtAYhp7bGGEZNqwZjhA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Fb1S1Sj1vVDOa8OxYc5R9qH8TRZd5VQvkWgxjsrU2sJEryQQQoDch3DyLYrfN281v
         bI5z3QYMnYVemMDu86I3X100EFxB1EAJVIUR02Xihe86r64x4MJeouFIyHw0ohSzrI
         bM/2Oynq3kvIyhuqzpAZaAGBidcDsJdJmUEJ8ULo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8xhLw8ix8LKo; Wed, 13 Jan 2021 15:56:42 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1FEF31280965;
        Wed, 13 Jan 2021 15:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610582201;
        bh=q5pGq2KcrqVHwr6DWLs6LIeKvtAYhp7bGGEZNqwZjhA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=jLQW+vdSzE4xCQJ+JTZQykAi09eeeVzkgHVIoIp5SUG+44q2hoeTq6UkuWrtniITW
         PyjfWOXdnY1ftmGa9xni5xHmB/ud3y9NIDVsV6eUNwR+sHAjRklliGxjVtpwMufHWy
         QvPNy1NKP0phQ0OUpfhZxyd/wrjjusO+nnHRD4qQ=
Message-ID: <c33c8e3839a41e9654f41cc92c7231104931b1d7.camel@HansenPartnership.com>
Subject: Re: [PATCH] certs: Add EFI_CERT_X509_GUID support for dbx entries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc:     jarkko@kernel.org, eric.snowberg@oracle.com,
        ard.biesheuvel@linaro.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Jan 2021 15:56:39 -0800
In-Reply-To: <2660556.1610545213@warthog.procyon.org.uk>
References: <2660556.1610545213@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2021-01-13 at 13:40 +0000, David Howells wrote:
> Hi Linus,
> 
> Are you willing to take this between merge windows - or does it need
> to wait for the next merge window?  It's not technically a bug fix to
> the kernel, but it does have a CVE attached to it.
> 
> Note that I've also updated Jarkko's address in his Reviewed-by since
> his Intel address no longer works.

Sorry, late to the party.

I suppose I lost the argument that we shouldn't really be trusting any
certs from db when shim is in operation because they're all EFI binary
signing ones and will usually simply be the microsoft certificate and
possibly an OEM platform one and we're usually pivoting the root of
trust to the certificates in the MokList.

However, if we are going to do this, we should also be blacklisting the
certificates in MokListX which the OS sees through MokListXRT.  Since
MokListX is an essential piece of our revocation infrastructure it
should have been mentioned in the CVE but wasn't for some reason.

James


