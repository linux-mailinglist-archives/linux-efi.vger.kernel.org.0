Return-Path: <linux-efi+bounces-2824-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1193AA43FEF
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2025 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9411895796
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2025 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C1269806;
	Tue, 25 Feb 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xma5Ceb1"
X-Original-To: linux-efi@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F501268FE4
	for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488358; cv=none; b=VNQJxPedBTvpEXVNWJxsH1+gPQDy8GiWBlGyaP5FqxMYr72asHxo3j/H0Ri2pnmEyopdAWIjKNWUVaKqEOpjdAC+QTG4iDn//uSMfVti8Y24MPfxRIP8cUGm4FPwY1tRJlQ8waJOw/oBhn7cQ5W2JuxKhG337PY2G62Mr1cAXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488358; c=relaxed/simple;
	bh=M/uBiPmiGoP1PqDfPklVexxBUAYa586ED+qXvyHWU5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1HDinnUAQ08YDLsdJqOBSlrFhOhP/ZleAQzCXTZlcHE3WjJPHGo6klQTDOn4OEK6kWnS/WT5u6Lf6OV74cH129AsvTgO8T8SvM++uZArah3U91IzPXxB82UK0NhR1L3XwVfZV41OrP9iwENgn06I6/z6azksEC9j5CbFN/mG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xma5Ceb1; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740488355;
	bh=M/uBiPmiGoP1PqDfPklVexxBUAYa586ED+qXvyHWU5Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=xma5Ceb1l0XHgjuHDkEVGRisp5L1iYCIjcYEW8zneuw94yeq26TofrgtvCVqP2Ta5
	 d5CYd03KDJx5hDiBMzLhqBP5d43H0yYwz3HNgznRcBs2Y4YqDvwPEVxCfJiyZ9cfZs
	 EvQg6StnKI//TzYaV40+270zbEvF0WzOcfBTpmCw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 22D631C255D;
	Tue, 25 Feb 2025 07:59:15 -0500 (EST)
Message-ID: <ffd953c76d3a0bc0f88aeb319589632e8da032dc.camel@HansenPartnership.com>
Subject: Re: efivarfs: fix error on write to new variable leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Richard Hughes <richard@hughsie.com>, linux-efi@vger.kernel.org
Cc: "ardb@kernel.org" <ardb@kernel.org>
Date: Tue, 25 Feb 2025 07:59:14 -0500
In-Reply-To: <SBFUY-p4-fI9JOrQa51x141vKHs_rbFLw4q9kfPGAK8Z76PQfgYl6zM3nUjlOeIPY6PgEhqLFaSJkW0vdBVzET3MDYUBZwzmYCJuNK4TaYU=@hughsie.com>
References: 
	<SBFUY-p4-fI9JOrQa51x141vKHs_rbFLw4q9kfPGAK8Z76PQfgYl6zM3nUjlOeIPY6PgEhqLFaSJkW0vdBVzET3MDYUBZwzmYCJuNK4TaYU=@hughsie.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[added correct mailing list for bug report]
On Tue, 2025-02-25 at 12:10 +0000, Richard Hughes wrote:
> Hi,
> 
> I'm not sure what I'm supposed to do about:
> 
> commit 908af31f4896f2c0645031f8b74a89d3a8beb5b9
> Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date:   Sun Jan 19 10:12:12 2025 -0500
> 
>     efivarfs: fix error on write to new variable leaving remnants
>     
>     Make variable cleanup go through the fops release mechanism and
> use
>     zero inode size as the indicator to delete the file.  Since all
> EFI
>     variables must have an initial u32 attribute, zero size occurs
> either
>     because the update deleted the variable or because an
> unsuccessful
>     write after create caused the size never to be set in the first
> place.
>     In the case of multiple racing opens and closes, the open is
> counted
>     to ensure that the zero size check is done on the last close.
>     
>     Even though this fixes the bug that a create either not followed
> by a
>     write or followed by a write that errored would leave a remnant
> file
>     for the variable, the file will appear momentarily globally
> visible
>     until the last close of the fd deletes it.  This is safe because
> the
>     normal filesystem operations will mediate any races; however, it
> is
>     still possible for a directory listing at that instant between
> create
>     and close contain a zero size variable that doesn't exist in the
> EFI
>     table.
>     
>     Signed-off-by: James Bottomley
> <James.Bottomley@HansenPartnership.com>
>     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> It causes a regression in fwupd -- seen in
> https://github.com/fwupd/fwupd/issues/8495 and
> https://bugzilla.redhat.com/show_bug.cgi?id=2346831 so far -- and it
> seems broken for anyone (including me) updating to 6.14.

OK, so the problem with this as a bug report is that it doesn't explain
what you're doing.  However

> I can work around the behavior in
> https://github.com/fwupd/fwupd/pull/8500 (which is also the arguably
> correct thing to do) but it's going to cause a panic as I have to get
> an updated fwupd out on all distros so we'll need releases for
> multiple branches.

Reading the code in the fix, it looks like you were creating a file in
EFI (which is naturally zero length), then closing it (because glib gio
specifically has an API for this), then clearing the immutable bit and
then writing to it to actually create a variable?  

However, none of that dance is at all required.  A newly created file
naturally allows writing on the file descriptor you used to create it.
It's only if you open it again that the entry becomes immutable.  So
your update has the correct logic: if file exists clear immutable and
write otherwise add O_CREAT.

> I don't mind fixing fwupd (as it's doing a dumb thing) but could we
> revert the kernel change for 6.14 and give everyone a few weeks to
> update userspace? Thanks.

The change is rather embedded in a set of other fixes now.  If we
wanted a temporary and quickly removable work around for the current
kernel, I think using i_size to signal whether the file is newly
created and not written (0) or failed a write (1) and only removing the
file if it failed a write might be a simple two line fix.  That way we
still keep the benefit of cleanup on a failed write while not impacting
your pattern.

Can you confirm this has that effect?

Regards,

James

---

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index cb1b6d0c3454..c294a8fc566d 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -57,10 +57,11 @@ static ssize_t efivarfs_file_write(struct file *file,
 
 	if (bytes == -ENOENT) {
 		/*
-		 * zero size signals to release that the write deleted
-		 * the variable
+		 * FIXME: temporary workaround for fwupdate, signal
+		 * failed write with a 1 to keep created but not
+		 * written files
 		 */
-		i_size_write(inode, 0);
+		i_size_write(inode, 1);
 	} else {
 		i_size_write(inode, datasize + sizeof(attributes));
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
@@ -124,7 +125,8 @@ static int efivarfs_file_release(struct inode *inode, struct file *file)
 	struct efivar_entry *var = inode->i_private;
 
 	inode_lock(inode);
-	var->removed = (--var->open_count == 0 && i_size_read(inode) == 0);
+	/* FIXME: temporary work around for fwupdate */
+	var->removed = (--var->open_count == 0 && i_size_read(inode) == 1);
 	inode_unlock(inode);
 
 	if (var->removed)


