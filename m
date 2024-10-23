Return-Path: <linux-efi+bounces-2012-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD89ABB74
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2024 04:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1B6B229FE
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2024 02:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32424644E;
	Wed, 23 Oct 2024 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV52kJ4F"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855FB1CA81;
	Wed, 23 Oct 2024 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650364; cv=none; b=C4LTdGIcwl02HZYq9X5NZA0fQ5lWUZlZE32NLzoeM71xs8BAYdUz82fOJNZsGo7HbkM7e/uaKjpOjcBpj+ykhVTK9y6UcS8ly0X6rHqxmOiTPUU/QmNskNFoPBsNU30dZPe7w72AbjQwk+uDU1mkf/R/N7z7rwiFpwqC4cnkyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650364; c=relaxed/simple;
	bh=aJii0wlPQcMK44UHYw5Iz7PQVdWdQ12Cr0ITPClYgIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNoM0RU9LwBOP+C5VU0Tybt8+B3A7kQ7SZ0IGOAC5xp41/2Pv3MYR1VuSwdOmJcbweV3xxjOpzJ7tuu9TfFuneMOfMgW6uJI0D3quoppjPjH9LAglXMNpt2VUDtKLAiuoSCTt2hIGGc/IrmbApBoXEaXEFGRJ2obcod5B4WklDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV52kJ4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6AFC4CEC3;
	Wed, 23 Oct 2024 02:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729650364;
	bh=aJii0wlPQcMK44UHYw5Iz7PQVdWdQ12Cr0ITPClYgIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OV52kJ4FsxxzSBeENS9k+vcJvi+ee8AteRf6pAEJ5C898hJZHVv+c0qxAgvxKg+V4
	 mGC+m2E3vfYYx8dMPANNIqOhoGMCgcnW7DAfZ+XtUfqiLOu08IK6bfR31xshoSbmY2
	 h5fP3+I30WpQLxqAQTceTfQQuI/SEtDmM6butPlopBcZEETjp9eUc5AVIFyYzT28Ht
	 yfsDUqcCIb5v9akypZpj01PblzSAsayHU/u+ulfJluHM9lL1tqI/VrXBirbpluj3+F
	 Nc2MmWc1DafcpuJfabZIYqZIsUYAuxC9h5/NKMv9XKanH7yKlGJCIkKr7HJV2P5fCQ
	 JxEv+74sIAqKg==
Date: Wed, 23 Oct 2024 02:25:56 +0000
From: sergeh@kernel.org
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: linux-security-module@vger.kernel.org, dhowells@redhat.com,
	dwmw2@infradead.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
	stefanb@linux.ibm.com, ebiggers@kernel.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
Message-ID: <ZxhetCy5RE1k4_Jk@lei>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-9-eric.snowberg@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017155516.2582369-9-eric.snowberg@oracle.com>

On Thu, Oct 17, 2024 at 09:55:11AM -0600, Eric Snowberg wrote:
> Introduce a new LSM called clavis.  The motivation behind this LSM is to
> provide access control for system keys.  The access control list is
> contained within a keyring call .clavis.  During boot if the clavis= boot
> arg is supplied with a key id contained within any of the current system
> keyrings (builtin, secondary, machine, or platform) it shall be used as
> the root of trust for validating anything that is added to the ACL list.
> 
> The first restriction introduced with this LSM is the ability to enforce
> key usage.  The kernel already has a notion of tracking key usage.  This
> LSM adds the ability to enforce this usage based on the system owners
> configuration.
> 
> Each system key may have one or more uses defined within the ACL list.
> Until an entry is added to the .clavis keyring, no other system key may
> be used for any other purpose.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  Documentation/admin-guide/LSM/clavis.rst      | 191 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  crypto/asymmetric_keys/signature.c            |   4 +
>  include/linux/lsm_count.h                     |   8 +-
>  include/linux/lsm_hook_defs.h                 |   2 +
>  include/linux/security.h                      |   7 +
>  include/uapi/linux/lsm.h                      |   1 +
>  security/Kconfig                              |  10 +-
>  security/clavis/Makefile                      |   1 +
>  security/clavis/clavis.c                      |  26 +++
>  security/clavis/clavis.h                      |   4 +
>  security/clavis/clavis_keyring.c              |  78 ++++++-
>  security/security.c                           |  13 ++
>  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
>  14 files changed, 346 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/clavis.rst
>  create mode 100644 security/clavis/clavis.c
> 
> diff --git a/Documentation/admin-guide/LSM/clavis.rst b/Documentation/admin-guide/LSM/clavis.rst
> new file mode 100644
> index 000000000000..0e924f638a86
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/clavis.rst
> @@ -0,0 +1,191 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======
> +Clavis
> +======
> +
> +Clavis is a Linux Security Module that provides mandatory access control to
> +system kernel keys (i.e. builtin, secondary, machine and platform). These
> +restrictions will prohibit keys from being used for validation. Upon boot, the
> +Clavis LSM is provided a key id as a boot parameter.  This single key is then
> +used as the root of trust for any access control modifications made going
> +forward. Access control updates must be signed and validated by this key.
> +
> +Clavis has its own keyring.  All ACL updates are applied through this keyring.
> +The update must be signed by the single root of trust key.
> +
> +When enabled, all system keys are prohibited from being used until an ACL is
> +added for them.
> +
> +On UEFI platforms, the root of trust key shall survive a kexec. Trying to
> +defeat or change it from the command line is not allowed.  The original boot
> +parameter is stored in UEFI and will always be referenced following a kexec.

Does this mean someone can reboot the host, boot another OS, store a key
id in UEFI, and force the root of trust key to be one other than what
the user lists in clavis= boot argument?

Never mind!  Saw the answer in patches 10 and 11, thanks.

> +The Clavis LSM contains a system keyring call .clavis.  It contains a single

s/call/called/

> +asymmetric key that is used to validate anything added to it.  This key can
> +be added during boot and must be a preexisting system kernel key.  If the
> +``clavis=`` boot parameter is not used, any asymmetric key the user owns

Who is "the user", and precisely what does "owns' mean here?  Is it just
restating that it must be a key already in one of the builtin or secondary
or platform keyrings?

And this is done by simply loading it into the clavis keyring, right?

-serge

